#include <stdio.h>
#include <stdint.h>
#include <stdbool.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <emmintrin.h>

inline __m128i unpack(uint8_t * mem){
    __m128i vec = _mm_loadu_si128((__m128i*)(mem));
    __m128i mask = _mm_set_epi8(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 255, 255, 255, 255,  255, 255);
    __m128i buflow = _mm_unpacklo_epi8(vec,_mm_srli_si128(vec,3)); 
    buflow = _mm_and_si128(buflow,mask);
    //buflow = _mm_srli_si128(_mm_slli_si128(buflow,10),10);
    __m128i bufhigh = _mm_unpacklo_epi8(_mm_srli_si128(vec,6),_mm_srli_si128(vec,9)); 
    bufhigh = _mm_and_si128(bufhigh,mask);
    //bufhigh = _mm_srli_si128(_mm_slli_si128(bufhigh,10),10);
    __m128i chunk4 = _mm_unpacklo_epi16(buflow, bufhigh);
    return chunk4;
}
inline __m128i madd3(__m128i a, __m128i b, __m128i c, int ka, int kb, int kc){
  __m128i sub1=_mm_set_epi16(ka, kb, ka, kb, ka, kb, ka, kb);
  a = _mm_slli_epi32(a, 16);
  a = _mm_or_si128(a, b);
  sub1 =_mm_madd_epi16(sub1,a);
  __m128i sub3=_mm_set1_epi16(kc);
  sub3 =_mm_madd_epi16(sub3,c);
  sub1 = _mm_add_epi32(sub1,sub3);
  sub1 = _mm_srai_epi32(sub1,10);
  return sub1;
}				
void process_vector(uint8_t *src,uint8_t *dst,int width,int height)
{
  
	for(int y=0;y<height;++y)
		for(int x=0;x<width;x+=4){
			//printf("%d %d\n",x,y);
      __m128i chanels = unpack(src + (y * width*3 + x*3));
      
      __m128i res = _mm_setzero_si128();
      __m128i r = _mm_unpacklo_epi16(_mm_unpacklo_epi8(chanels,res),res);
      __m128i g = _mm_unpacklo_epi16(_mm_unpacklo_epi8(_mm_srli_si128(chanels,4),res),res);
      __m128i b = _mm_unpacklo_epi16(_mm_unpacklo_epi8(_mm_srli_si128(chanels,8),res),res);
      
      r = _mm_slli_epi32(r,4);
      g = _mm_slli_epi32(g,14);
      b = _mm_slli_epi32(b,24);
      
      res = _mm_set1_epi32(0x03);
      res = _mm_or_si128(r,res);
      res = _mm_or_si128(g,res);
      res = _mm_or_si128(b,res);
      
      _mm_storeu_si128((__m128i*)(dst+ x*4 + y*width*4),res);
		}
}

void process_usuall(uint8_t *src,uint8_t *dst,int width,int height)
{
	uint8_t* outBuf=(uint8_t*)dst;
	uint32_t r,g,b;
	for(int i = 0; i < height; i++){
		for(int j = 0; j < width; j++){
		r=src[3*j+0]<<2; // BGR BGR BGR 
		g=src[3*j + 1]<<2;
		b=src[3*j + 2]<<2;
		outBuf[4 * j] = 3;
		
		outBuf[4 * j] |= (r & 0x3F)<<2; //A2R10G10B10
		outBuf[4 * j + 1] = (r >> 6);
		outBuf[4 * j + 1] |= (g & 0xF) << 4;
		outBuf[4 * j + 2] = (g >> 4);
		outBuf[4 * j + 2] |= (b & 3) << 6;
		outBuf[4 * j + 3] = (b >> 2);
		}
	src += width*3;
	outBuf += width*4;
	}
}

bool check(uint8_t* a,uint8_t* b,int width,int height){
	for(int y=0;y<height;++y)
		for(int x=0;x<width;++x)
		{
			//printf("a=%d  b= %d\n",a[y*width+x],b[y*width+x]);
			if(a[y*width+x]!=b[y*width+x])
			{
				printf("error pos is %d %d",y,x);
				return false;
			}
		}
	return true;
}
void createframe(int wid,int hei,uint8_t* res)
{
	srand(time(NULL));
	for(int y=0;y<hei;++y)
		for(int x=0;x<wid;++x)
			{
				res[y*wid+x]=rand()%256;
			}
}
int test()
{
	clock_t t1,t2;
	int testnum=100;
	uint64_t du,dv;
	int wid=640,hei=480;
	uint8_t test[]={10,11,12,20,21,22,30,31,32,40,41,42,50,51,52,60};
	//uint8_t test[]={200,200,230,240,250,260,270,280,290,100,110,120,130,140,150,160};
	//uint8_t test[]={100,200,130,40,50,60,70,80,90,100,110,120,130,140,150,160};

	uint8_t restest[16];
	memset(restest,0,16);
	uint8_t *src=(uint8_t*)malloc(wid*10*hei);
	uint8_t *dst1=(uint8_t*) malloc(wid*hei*4);
	uint8_t *dst2=(uint8_t*) malloc(wid*hei*4);
	puts("Usuall");
	process_usuall(test,restest,4,1);
	for(int i=0;i<4;++i)
	{
		printf("%4d ",restest[i]);
	}
	puts("Vector");
	memset(restest,0,16);
	process_vector(test,(uint8_t*)restest,4,1);

	for(int i=0;i<4;++i)
	{
		printf("%4d ",restest[i]);
	}
	puts("GO!");

	int fail=0;
	for(int i=0;i<testnum;++i)
	{
		createframe(wid*3,hei,src);
		process_usuall(src,dst1,wid,hei);
		process_vector(src,dst2,wid,hei);
		if(!check((uint8_t*)dst1,(uint8_t*)dst2,wid*4,hei))
		{
			 ++fail;
	  }
	}

	printf("You fail %d tests",fail);

	puts("\nUsuall process");
	du=0;
	for(int i=0;i<testnum;++i)
	{
		createframe(wid*3,hei,src);
		t1=clock();
		//printf("T1=%d\n",t1);
		process_usuall(src,dst1,wid,hei);
		t2=clock();
		//printf("T2=%d\n",t2);
		du+=t2-t1;
	}
	printf("Tics acc: %lld\n",du);

	puts("\nVector process");
	dv=0;
	for(int i=0;i<testnum;++i)
	{
		createframe(wid*3,hei,src);
		t1=clock();
		//printf("T1=%d\n",t1);
			process_vector(src,dst2,wid,hei);
		t2=clock();
		//printf("T2=%d\n",t2);
		dv+=t2-t1;
	}
	printf("Tics acc: %lld\n",dv);
	free(src);
	printf("\nperfomance koef is %f\n",1.*du/dv);
	return 0;
}
void fileProcess(int wid, int hei, char * name){
	FILE* f1=fopen(name,"rb");
	if(!f1){
		puts("Error of reading");
		return ;
	}
	uint8_t *src=(uint8_t*)malloc(wid*hei*2);
	uint8_t *dst=(uint8_t*)malloc(wid*hei*4);
	fread(src,1,wid*hei*2,f1);
	fclose(f1);
	process_vector(src,dst,wid,hei);
	FILE* f2=fopen("out.rgb","wb");
	fwrite(dst,1,wid*hei*4,f1);
	fclose(f2);

}
int main()
{
	test();
	//fileProcess(176,144,"out.yuv");
	return 0;
}
