#include <stdio.h>
#include <stdint.h>
#include <stdbool.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <emmintrin.h>
#define YKR   57 // Koeff of red for Y processing
#define YKG  148//  Koeff of red for Y processing
#define YKB   13//  Koeff of red for Y processing

#define UKR   9// Koeff of red for Y processing
#define UKG 102// Koeff of red for Y processing
#define UKB 112// Koeff of red for Y processing

#define VKR 112 // Koeff of red for Y processing
#define VKG  80 // Koeff of red for Y processing
#define VKB  31 // Koeff of red for Y processing
// Y = ( 57 * R + 148 * G + 13 * B ) >> 10 + 16;
// U = ( -9 * R  -102 * G +112 * B ) >> 10 + 128;
// V = (112 * R   -80 * G  -31 * B ) >> 10 + 128;
				
void process_vector(uint8_t *src,uint8_t *dst,int width,int height)
{
	for(int y=0;y<height;++y)
		for(int x=0;x<width;x+=4){
			__m128i vec=_mm_loadu_si128((__m128i*)(src+y*width*4+x*4));
			__m128i blue=_mm_set1_epi32(1023); // store of mask
			__m128i red=_mm_and_si128(_mm_srli_epi32(vec,2),blue);
			__m128i green=_mm_and_si128(_mm_srli_epi32(vec,12),blue);
			blue=_mm_and_si128(_mm_srli_epi32(vec,22),blue);
			
			vec=_mm_set1_epi32(16);
			// Y koefficents
			__m128i sub1=_mm_set1_epi32(YKR);
			__m128i sub2=_mm_set1_epi32(YKG);
			__m128i sub3=_mm_set1_epi32(YKB);
			
			sub1=_mm_madd_epi16(sub1,red);
			sub2=_mm_madd_epi16(sub2,green);
			sub3=_mm_madd_epi16(sub3,blue);
			vec=_mm_add_epi32(vec,_mm_srli_epi32(_mm_add_epi32(_mm_add_epi32(sub1,sub2),sub3),10));
			vec=_mm_packus_epi16(vec,_mm_setzero_si128());
			// 0 Y 0 Y
			__m128i resv=_mm_setzero_si128();
			resv=_mm_or_si128(vec,resv);
		  
		  	// U koefficents
		  	vec=_mm_set1_epi32(128);
			sub1=_mm_set1_epi32(UKR);
			sub2=_mm_set1_epi32(UKG);
			sub3=_mm_set1_epi32(UKB);
			
			sub1=_mm_madd_epi16(sub1,red);
			sub2=_mm_madd_epi16(sub2,green);
			sub3=_mm_madd_epi16(sub3,blue);
			//vec=_mm_srai_epi32(_mm_sub_epi32(_mm_sub_epi32(_mm_add_epi32(vec,sub3),sub2),sub1),10);
			vec=_mm_add_epi32(vec,_mm_srai_epi32(_mm_sub_epi32(_mm_sub_epi32(sub3,sub2),sub1),10));
			vec=_mm_avg_epu16(vec,_mm_slli_epi64(vec,32));
			
			vec=_mm_srli_epi64(vec,32);
			vec=_mm_packus_epi16(vec,_mm_setzero_si128());
			// 0 0 0 u
			resv=_mm_or_si128(_mm_slli_epi32(vec,8),resv);		
		  
			// V koefficents 
			vec=_mm_set1_epi32(128);
			sub1=_mm_set1_epi32(VKR);
			sub2=_mm_set1_epi32(VKG);
			sub3=_mm_set1_epi32(VKB);			
			sub1=_mm_madd_epi16(sub1,red);
			sub2=_mm_madd_epi16(sub2,green);
			sub3=_mm_madd_epi16(sub3,blue);
			//vec=_mm_srli_epi32(_mm_sub_epi32(_mm_sub_epi32(_mm_add_epi32(vec,sub1),sub2),sub3),10);
			vec=_mm_add_epi32(vec,_mm_srai_epi32(_mm_sub_epi32(_mm_sub_epi32(sub1,sub2),sub3),10));
			vec=_mm_avg_epu16(vec,_mm_slli_epi64(vec,32));
			vec=_mm_srli_epi64(vec,32); // 0 0 0 0 0 0 0 V
			vec=_mm_packus_epi16(vec,_mm_setzero_si128());
			// 0 0 0 v
			resv=_mm_or_si128(_mm_slli_epi32(vec,24),resv);		
		  
		  //resv = VYUY (inverse order)
		  _mm_storel_epi64((__m128i*)(dst+(x*2+y*width*2)),resv);
		}
}
void process_usuall(uint8_t *src,uint8_t *dst,int width,int height)
{
	int R, B, G;
	for(int i = 0; i < height; i++)
	{
		int red = 0;
		int green = 0;
		int blue = 0;
		for(int j = 0; j < width*4; j += 4)
		{
			R = (*(src) >> 2) | (*(src + 1) & 0xF) << 6;
			G = (*(src + 1) >> 4) | ((*(src + 2) & 0x3F) << 4);
			B = (*(src + 2) >> 6) | (*(src  + 3) << 2);
			src+=4;
			*dst = ( 57 * R + 148 * G + 13 * B + 16384) >> 10; //Y

			blue += R;
			green += G;
			red += B;
			if(((j >> 3) << 3) != j )
			{
				red >>= 1;
				green >>= 1;
				blue >>= 1;
				*(dst+1) = ( -31 * red - 80 * green + 112 * blue + 131072) >> 10; // V
				*(dst-1) =( 112 * red - 102 * green - 9 * blue + 131072) >> 10;// U
				red = green = blue=0;
			}

			dst += 2;
		}
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
	//uint8_t test[]={100,200,130,40,50,60,70,80,90,100,110,120,130,140,150,160};
	//uint8_t test[]={100,200,130,40,50,60,70,80,90,100,110,120,130,140,150,160};

	uint8_t restest[16];
	memset(restest,0,16);	
	uint8_t *src=(uint8_t*)malloc(wid*4*hei);
	uint8_t *dst1=(uint8_t*)malloc(wid*hei*2);
	uint8_t *dst2=(uint8_t*)malloc(wid*hei*2);
	puts("Usuall");
	process_usuall(test,restest,4,1);
	for(int i=0;i<16;++i)
	{
		printf("%4d ",restest[i]);
	}
	puts("Vector");
	memset(restest,0,16);
	process_vector(test,restest,4,1);
	for(int i=0;i<16;++i)
	{
		printf("%4d ",restest[i]);
	}
	puts("GO!");
	
	int fail=0;
	for(int i=0;i<testnum;++i)
	{
		createframe(wid*4,hei,src);
		process_usuall(src,dst1,wid,hei);
		process_vector(src,dst2,wid,hei);
		if(!check((uint8_t*)dst1,(uint8_t*)dst2,wid*2,hei))
		{
			 //puts("au");
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
	printf("Tics acc: %d\n",du);
	
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
	printf("Tics acc: %d\n",dv);
	free(src);
	printf("\nperfomance koef is %f",1.*du/dv);
	return 0;
}

int main()
{
	int wid=176;
	int hei=144;
	test();
	FILE* f1=fopen("line.rgb","rb");
	if(!f1){
		puts("Error of reading");
		return 0;
	}
	uint8_t *src=(uint8_t*)malloc(wid*hei*4);
	uint8_t *dst=(uint8_t*)malloc(wid*hei*4);
	fread(src,1,wid*hei*4,f1);
	fclose(f1);
	process_vector(src,dst,wid,hei);
	FILE* f2=fopen("out.yuv","wb");
	fwrite(dst,1,wid*hei*2,f1);
	fclose(f2);
	return 0;
}
