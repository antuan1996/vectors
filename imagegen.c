/*
 * imagegen.c
 * 
 * Copyright 2015 user <user@anton-WA50SFQ>
 * 
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 * 
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
 * MA 02110-1301, USA.
 * 
 * 
 */
#include <stdlib.h>
#include <stdio.h>
#include <stdint.h>
int main(int argc, char **argv)
{
	FILE *f=fopen("line.rgb","wb");
	int pointamm=25344;//176*144
	uint8_t redl[]={255,  15,0,0};
	uint8_t greenl[]={0b11,240,63,0};
	uint8_t bluel[]= {0b11, 0,192,255};
	uint8_t* outbuf=(uint8_t*)malloc(pointamm*4);
	int cur=0;	
	for(int i=0;i<pointamm/3;++i){
		 memcpy((void*)(outbuf+cur*4),(void*)(redl),4);
		 ++cur;
	}
	for(int i=0;i<pointamm/3;++i){
		 memcpy((void*)(outbuf+cur*4),(void*)(greenl),4);
		 ++cur;
	}
	for(int i=0;i<pointamm/3;++i){
		 memcpy((void*)(outbuf+cur*4),(void*)(bluel),4);
		 ++cur;
	}
	fwrite(outbuf,1,pointamm*4,f);
	fclose(f);
	return 0;
}

