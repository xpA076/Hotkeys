// Dll_face.cpp : 定义 DLL 应用程序的导出函数。
//

#include "stdafx.h"
#include<iostream>
#include<string>
#include"CopyScreen.h"

struct MyPoint
{
	int x;
	int y;
};
struct MyRect
{
	int l;
	int r;
	int t;
	int b;
};
struct MyPath
{
	int filenum1;
	int filenum2;
	int imgnum1;
	int imgnum2;
};



extern "C" _declspec(dllexport) int add(int a, int b) {
	a = a + 1;
	return sizeof(a);
}


extern "C" _declspec(dllexport) int test1(MyPoint* ms) {
	// ms里面的数值不能修改只能读取不知道为啥不过不重要
	return ms->x + ms->y;
}

// 返回值为minVal
extern "C" _declspec(dllexport) double GetImagePosition2(int* px, int* py, MyRect* rect,MyPath* spath,MyRect* mask) {
	std::string subpath = "";
	if (spath->filenum2 != 0) {
		subpath = std::to_string(spath->filenum2) + "\\";
	}

	std::string strpath = "CapsLock_image\\" + std::to_string(spath->filenum1) + "\\" + subpath;
	std::string imgname= std::to_string(spath->imgnum1) + "_" + std::to_string(spath->imgnum2) + ".png";


	cv::Mat img;
	img = cv::imread(cv::String(strpath + imgname));

	cv::Mat t;
	if (mask->r == mask->l) {
		img.copyTo(t);
	}
	else {
		t = img(cv::Rect(mask->l, mask->t, mask->r - mask->l, mask->b - mask->t));
	}

	return (_GetTemplateCenterPosition(img, px, py, rect->l, rect->r, rect->t, rect->b));

}