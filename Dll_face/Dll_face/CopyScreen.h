#pragma once
#include<windows.h>
#include <opencv2/opencv.hpp>


IplImage* ScreenRoiCapture(int x1, int x2, int y1, int y2) {

	LPVOID screenCaptureData = NULL;
	HBITMAP hBitmap;
	HDC hDDC;
	HDC hCDC;



	int nWidth = x2 - x1;
	int nHeight = y2 - y1;

	screenCaptureData = new char[nWidth*nHeight * 4];
	memset(screenCaptureData, 0, nWidth);
	// Get desktop DC, create a compatible dc, create a comaptible bitmap and select into compatible dc.
	hDDC = GetDC(GetDesktopWindow());//得到屏幕的dc
	hCDC = CreateCompatibleDC(hDDC);//
	hBitmap = CreateCompatibleBitmap(hDDC, nWidth, nHeight);//得到位图
	SelectObject(hCDC, hBitmap); //好像总得这么写。
	BitBlt(hCDC, 0, 0, nWidth, nHeight, hDDC, x1, y1, SRCCOPY);

	GetBitmapBits(hBitmap, nWidth*nHeight * 4, screenCaptureData);//得到位图的数据，并存到screenCaptureData数组中。
	IplImage *img = cvCreateImage(cvSize(nWidth, nHeight), 8, 4);//创建一个rgba格式的IplImage
	memcpy(img->imageData, screenCaptureData, nWidth*nHeight * 4);//这样比较浪费时间，但写的方便。这里必须得是*4，上面的链接写的是*3，这是不对的。

	return img;
}


IplImage* ScreenRoiCapture(LPRECT lprect) {
	return ScreenRoiCapture(lprect->left, lprect->right, lprect->top, lprect->bottom);
}


double _GetTemplateCenterPosition(cv::Mat t,int* xpos,int* ypos, int x1, int x2, int y1, int y2 ) {
	IplImage* img = ScreenRoiCapture(x1, x2, y1, y2);
	cv::Mat screenroi;
	cv::cvtColor(cv::cvarrToMat(img), screenroi, CV_BGRA2BGR);



	cv::Mat match; //result
	cv::matchTemplate(screenroi, t, match, cv::TM_SQDIFF_NORMED);

	double minVal, maxVal;
	cv::Point minLoc, maxLoc;
	cv::minMaxLoc(match, &minVal, &maxVal, &minLoc, &maxLoc);



	*xpos = minLoc.x + t.cols / 2;
	*ypos = minLoc.y + t.rows / 2;
	return minVal;


}



