#include <stdio.h>
#include <stdint.h>
#include <stdbool.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <emmintrin.h>
void process_vector2(uint8_t *src,uint32_t *dst,int width,int height)
{
	int t;
	for(t=0;t<width*height*3-11;t+=12){
				
					__m128i vec=_mm_loadu_si128((__m128i*)src);
					src+=12;
				
					//shufle to r1 r2 r3 r4 g2 g1 g4 g3 b1 b2 b3 b4
					vec=_mm_slli_si128(vec,1);
					vec=_mm_shufflelo_epi16(vec,_MM_SHUFFLE(3,1,2,0));
					vec=_mm_shufflehi_epi16(vec,_MM_SHUFFLE(3,2,0,1));		
					vec=_mm_srli_si128(vec,1);
					vec=_mm_shufflelo_epi16(vec,_MM_SHUFFLE(2,1,3,0));
					vec=_mm_slli_si128(vec,2);
					vec=_mm_shufflehi_epi16(vec,_MM_SHUFFLE(3,2,0,1));
					vec=_mm_srli_si128(vec,2);
					// 0 0 0 0 b b b b g g g g r r r r
			
					__m128i resv;
					resv=_mm_set1_epi16(0x03); // alfa
					//resv=_mm_slli_epi32(resv,24);
					
					__m128i subv1=_mm_setzero_si128();
					resv=_mm_unpacklo_epi16(resv,_mm_unpacklo_epi8(_mm_srli_si128(vec,8),subv1));
					__m128i chan=_mm_unpacklo_epi8(subv1,_mm_srli_si128(vec,4));
					chan=_mm_shufflelo_epi16(chan,_MM_SHUFFLE(2,3,0,1));
					chan=_mm_slli_epi16(chan,2);
					chan=_mm_unpacklo_epi16(chan,_mm_unpacklo_epi8(vec,subv1));
					chan=_mm_slli_epi32(chan,4);
					chan=_mm_slli_si128(chan,1);
					resv=_mm_or_si128(_mm_slli_epi32(chan,24),resv);
					resv=_mm_or_si128(_mm_slli_epi32(_mm_srli_epi32(chan,8),16),resv);
					resv=_mm_or_si128(_mm_slli_epi32(_mm_srli_epi32(chan,16),8),resv);
					
					_mm_storeu_si128((__m128i*)dst,resv);
					dst+=4;		
			}
	// It's palce for Finish
}
void process_vector(uint8_t *src,uint32_t *dst,int width,int height)
{
	int t;
	for(t=0;t<width*height*3-11;t+=12){
				
					__m128i vec=_mm_loadu_si128((__m128i*)src);
					src+=12;
				
					//shufle to r1 r2 r3 r4 g2 g1 g4 g3 b1 b2 b3 b4
					vec=_mm_slli_si128(vec,1);
					vec=_mm_shufflelo_epi16(vec,_MM_SHUFFLE(3,1,2,0));
					vec=_mm_shufflehi_epi16(vec,_MM_SHUFFLE(3,2,0,1));		
					vec=_mm_srli_si128(vec,1);
					vec=_mm_shufflelo_epi16(vec,_MM_SHUFFLE(2,1,3,0));
					vec=_mm_slli_si128(vec,2);
					vec=_mm_shufflehi_epi16(vec,_MM_SHUFFLE(3,2,0,1));
					vec=_mm_srli_si128(vec,2);
				
			
					__m128i resv;
					resv=_mm_set1_epi32(0x03); // alfa
					//resv=_mm_slli_epi32(resv,24);
					
					__m128i subv1=_mm_setzero_si128();
					__m128i chan;
					
					
					//RED
					chan=_mm_unpacklo_epi16(_mm_unpacklo_epi8(subv1,vec),subv1);
					chan=_mm_srli_epi32(chan,4);
					chan=_mm_or_si128(chan,_mm_srli_si128(chan,2));
					chan=_mm_srli_epi32(_mm_slli_epi32(chan,16),16);
					resv=_mm_or_si128(chan,resv);
					
					//Green
					chan=_mm_unpacklo_epi16(_mm_unpacklo_epi8(subv1,_mm_srli_si128(vec,4)),subv1);
					chan=_mm_shuffle_epi32(chan,_MM_SHUFFLE(2,3,0,1));
					chan=_mm_srli_epi32(chan,2);
					chan=_mm_or_si128(chan,_mm_srli_si128(chan,2));
					chan=_mm_srli_epi32(_mm_slli_epi32(chan,16),16);
					resv=_mm_or_si128(_mm_slli_si128(chan,1),resv);
					
					
					//BLUe
					//chan=_mm_unpacklo_epi16(_mm_unpacklo_epi8(subv1,_mm_srli_si128(vec,8)),subv1);
					//chan=_mm_shuffle_epi32(chan,_MM_SHUFFLE(3,2,0,1));
					//chan=_mm_srli_epi32(chan,2);
					//chan=_mm_or_si128(chan,_mm_srli_si128(chan,2));
					//chan=_mm_srli_epi32(_mm_slli_epi32(chan,16),16);
					resv=_mm_or_si128(_mm_slli_si128(chan,2),resv);
					
					
					_mm_storeu_si128((__m128i*)dst,resv);
					dst+=4;		
			}
	// It's palce for Finish
}
void process_usuall(uint8_t *src,uint32_t *dst,int width,int height)
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
uint8_t* createframe(int wid,int hei)
{
	uint8_t * res=(uint8_t*)malloc(wid*hei);
	srand(time(NULL));
	for(int y=0;y<hei;++y)
		for(int x=0;x<wid;++x)
			{
				res[y*wid+x]=rand()%256;
			}
	return res;
}
int main()
{
	clock_t t1,t2;
	int testnum=100;
	uint64_t du,dv;
	int wid=640,hei=480;
	uint8_t test[]={10,11,12,20,21,22,30,31,32,40,41,42,50,51,52,60};
	//uint8_t test[]={100,200,130,40,50,60,70,80,90,100,110,120,130,140,150,160};
	//uint8_t test[]={100,200,130,40,50,60,70,80,90,100,110,120,130,140,150,160};

	uint8_t restest[16];	
	uint8_t *src;
	uint32_t *dst1=(uint32_t*)malloc(wid*hei*sizeof(uint32_t));
	uint32_t *dst2=(uint32_t*)malloc(wid*hei*sizeof(uint32_t));
	
	process_usuall(test,(uint32_t*)restest,4,1);
	for(int i=0;i<16;++i)
	{
		printf("%d ",restest[i]);
	}
	puts("");
	process_vector(test,(uint32_t*)restest,6,1);
	for(int i=0;i<16;++i)
	{
		printf("%d ",restest[i]);
	}
	puts("GO!");
	
	
	int fail=0;
	for(int i=0;i<testnum;++i)
	{
		src=createframe(wid*3,hei);
		process_usuall(src,dst1,wid,hei);
		process_vector(src,dst2,wid,hei);
		if(!check((uint8_t*)dst1,(uint8_t*)dst2,wid,hei))
		{
			 //puts("au");
			 ++fail;
	  }
		free(src);
	}
	printf("You fail %d tests",fail);
	
	puts("\nUsuall process");
	du=0;
	src=(uint8_t*)malloc(3*wid*hei*sizeof(uint8_t));
	
	for(int i=0;i<testnum;++i)
	{
		src=createframe(wid*3,hei);
		t1=clock();
		//printf("T1=%d\n",t1);
		process_usuall(src,dst1,wid,hei);
		t2=clock();
		//printf("T2=%d\n",t2);
		du+=t2-t1;
		free(src);
	}
	printf("Tics acc: %d\n",du);
	
	puts("\nVector process");
	dv=0;
	for(int i=0;i<testnum;++i)
	{
		src=createframe(wid*3,hei);
		t1=clock();
		//printf("T1=%d\n",t1);
			process_vector2(src,dst2,wid,hei);
		t2=clock();
		//printf("T2=%d\n",t2);
		dv+=t2-t1;
		free(src);
	}
	printf("Tics acc: %d\n",dv);
	
	printf("\nperfomance koef is %f",1.*du/dv);
	return 0;
}
