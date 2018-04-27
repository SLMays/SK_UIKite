/************************************************************************/
/* copyright                                                            */
/************************************************************************/
#ifndef __EX_CARDS_H__
#define __EX_CARDS_H__

#include "commondef.h"

//////////////////////////////////////////////////////////////////////////

STD_API(int)	EXCARDS_Init(const char *szWorkPath);
STD_API(void)	EXCARDS_Done(void);
STD_API(float)  EXCARDS_GetFocusScore(unsigned char *yimgdata, int width, int height, int pitch, int lft, int top, int rgt, int btm);


STD_API(int)	EXCARDS_RecoIDCardFile(const char *szImgFile, char *szResBuf, int nResBufSize);
STD_API(int)	EXCARDS_RecoIDCardData(unsigned char *pbImage, int nWidth, int nHeight, int nPitch, int nBitCount, char *szResBuf, int nResBufSize);

#endif

