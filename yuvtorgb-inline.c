#include <stdio.h>
#include <stdint.h>
#include <stdbool.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <emmintrin.h>
#define RKY  4778 // Koeff of  Y for red  processing
#define RKU  2		//  Koeff of  U for red processing
#define RKV  6931	//  Koeff of 	V for red processing

#define GKY  4826 // Koeff of Y for green processing
#define GKU  -775 // Koeff of U for green processing
#define GKV  -2670// Koeff of V for green processing

#define BKY  4768// Koeff of Y for blue processing
#define BKU  8809// Koeff of U for blue processing
#define BKV    11// Koeff of V for blue processing
//B = (BKY * (Y-16) + BKU * (U-128) + BKV * (V-128)) >> 10;
//G = (GKY * (Y-16) + GKU * (U-128) + GKV * (V-128)) >> 10;
//R = (RKY * (Y-16) + RKU * (U-128) + RKV * (V-128)) >> 10;
inline void unpack(uint8_t * mem, __m128i* y, __m128i* u ,__m128i* v){
    __m128i vec=_mm_loadl_epi64((__m128i*)(mem));

    *v = _mm_set1_epi16(255); // store of mask
    *y = _mm_and_si128(*v,vec);
    *u = _mm_srli_epi32(*v,8);
    *u =_mm_and_si128(*u,vec);
    *v = _mm_slli_epi32(*v,24);
    *v=_mm_and_si128(*v,vec);

    vec=_mm_setzero_si128();

    *u = _mm_srli_epi32(*u,8); // 0 0 0 u
    *v = _mm_srli_epi32(*v,24);// 0 0 0 v

    *u =  _mm_or_si128(*u,_mm_slli_epi32(*u,16)); // 0 u 0 u
    *v = _mm_or_si128(*v,_mm_slli_epi32(*v,16)); // 0 v 0 v

    *y = _mm_sub_epi16(*y,_mm_set1_epi16(16));
    *u = _mm_sub_epi16(*u,_mm_set1_epi16(128));
    *v = _mm_sub_epi16(*v,_mm_set1_epi16(128));

    *y = _mm_unpacklo_epi16(*y,vec);
    *u = _mm_unpacklo_epi16(*u,vec);
    *v = _mm_unpacklo_epi16(*v,vec);
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
inline __m128i  upBound(__m128i reg, uint32_t value){
      __m128i sub3 = _mm_set1_epi32(value);
			__m128i sub2 = _mm_cmplt_epi32(reg,sub3);
			reg = _mm_and_si128(reg,sub2);
			sub2 = _mm_andnot_si128(sub2,sub3);
			reg = _mm_or_si128(reg,sub2);
      return reg;
}
inline __m128i lowBoundZero(__m128i reg){
      __m128i sub3 = _mm_setzero_si128();
			__m128i sub2 = _mm_cmpgt_epi32(reg,sub3);
			reg = _mm_and_si128(reg,sub2);
      return reg;
}
void process_vector(uint8_t *src,uint8_t *dst,int width,int height)
{
	for(int i=0;i<height;++i)
		for(int j=0;j<width;j+=4){
		
      __m128i y;
      __m128i u;
      __m128i v;
      unpack(src+i*width*2+j*2,&y,&u,&v);
			//alfa
			__m128i vec = _mm_set1_epi32(3);
      
      __m128i sub1 = madd3(y,u,v,RKY,RKU,RKV);
      sub1 = upBound(sub1, 1023);
      sub1 = lowBoundZero(sub1);
      sub1 = _mm_slli_epi32(sub1,2);

			vec=_mm_or_si128(vec,sub1);

			//G component
      sub1 = madd3(y,u,v, GKY,GKU,GKV);
			sub1 = upBound(sub1, 1023);
      sub1 = lowBoundZero(sub1);

			sub1 = _mm_slli_epi32(sub1,12);

			vec=_mm_or_si128(vec,sub1);

			//	B component
			sub1 = madd3(y,u,v,BKY,BKU,BKV);
			sub1 = upBound(sub1, 1023);
      sub1 = lowBoundZero(sub1);
      
      sub1 = _mm_slli_epi32(sub1,22);

			vec=_mm_or_si128(vec,sub1);

		  _mm_storeu_si128((__m128i*)(dst+(j*4+i*width*4)),vec);
		}
}
void process_usuall(uint8_t *src,uint8_t *dst,int width,int height)
{
	int Y,V,U;
	int R, G, B;

	for(int i = 0; i < height; i++)
	{
		for(int j = 0; j < width; j++)
			{
					Y = src[2*j] - 16;
					if(((j >> 1) << 1) == j )
						{
							U = src[2*j+1] - 128;
							V = src[2*j+3] - 128;
						}

					B = (4768 * Y + 8809 * U + 11 * V) >> 10;

					if(B > 0x3FF) B = 0x3FF;
					if(B < 0) B = 0;

					G = (4826 * Y - 775 * U - 2670 * V) >> 10;
					if(G > 0x3FF) G = 0x3FF;
					if(G < 0) G = 0;

					R = (4778 * Y + 2 * U + 6931 * V) >> 10;

					if(R > 0x3FF) R = 0x3FF;
					if(R < 0) R = 0;

					//memcpy(dst+4 * j,&B,4);

					dst[4*j] = 3;
					dst[4 * j] |= (R & 0x3F) << 2;

					dst[4 * j + 1] = (R >> 6);
					dst[4 * j + 1] |= (G & 0xF) << 4;

					dst[4 * j + 2] = (G >> 4);
					dst[4 * j + 2] |= (B & 3) << 6;

					dst[4 * j + 3] = (B >> 2);
			}
		src+=2*width;
		dst+=4*width;
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
	//uint8_t test[]={10,11,12,20,21,22,30,31,32,40,41,42,50,51,52,60};
	//uint8_t test[]={200,200,230,240,250,260,270,280,290,100,110,120,130,140,150,160};
	uint8_t test[]={100,200,130,40,50,60,70,80,90,100,110,120,130,140,150,160};

	uint32_t restest[4];
	memset(restest,0,16);
	uint8_t *src=(uint8_t*)malloc(wid*2*hei);
	uint8_t *dst1=(uint8_t*)malloc(wid*hei*4);
	uint8_t *dst2=(uint8_t*)malloc(wid*hei*4);
	puts("Usuall");
	process_usuall(test,(uint8_t*)restest,4,1);
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
		createframe(wid*2,hei,src);
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
		createframe(wid*2,hei,src);
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
		createframe(wid*2,hei,src);
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
	fileProcess(176,144,"out.yuv");
	return 0;
}
