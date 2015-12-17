//
//  ScanQRCodeView.m
//  LBZBar
//
//  Created by kingly on 15/12/17.
//  Copyright © 2015年 kingly. All rights reserved.
//

#import "ScanQRCodeView.h"
#import "ColorUtil.h"
#define kScreenWidth ([[UIScreen mainScreen]bounds].size.width)//屏幕宽度
#define kScreenHeight ([[UIScreen mainScreen]bounds].size.height > [[UIScreen mainScreen]bounds].size.width?[[UIScreen mainScreen]bounds].size.height:[[UIScreen mainScreen]bounds].size.width)//屏幕高度

@interface ScanQRCodeView (){

    UILabel * labIntroudction;
    UIImageView *imageView;
    UIImageView *_line;

}
@end


@implementation ScanQRCodeView

-(instancetype)init
{
    if (self = [super init]) {
        [self addCustomView];
    }
    
    return self;
}

/**
 * 添加子视图
 */
-(void)addCustomView
{
    
    labIntroudction= [[UILabel alloc] initWithFrame:CGRectMake((kScreenWidth-290)/2, 25, 290, 75)];
    labIntroudction.backgroundColor = [UIColor clearColor];
    labIntroudction.numberOfLines = 4;
    labIntroudction.textColor=[UIColor whiteColor];
    labIntroudction.text =@"将二维码图像置于矩形方框内,离手机摄像头10CM左右,系统会自动识别.";
    labIntroudction.font = [UIFont boldSystemFontOfSize:15];
    [self addSubview:labIntroudction];
    
    
    imageView = [[UIImageView alloc]initWithFrame:CGRectMake((kScreenWidth-300)/2, 100, 300, 300)];
    imageView.image = [UIImage imageNamed:@"pick_bg"];
    [self addSubview:imageView];
    
    upOrdown = NO;
    num =0;
    _line = [[UIImageView alloc] initWithFrame:CGRectMake((kScreenWidth-220)/2, 110, 220, 2)];
    _line.image = [UIImage imageNamed:@"line"];
    [self addSubview:_line];
    
    timer = [NSTimer scheduledTimerWithTimeInterval:.02 target:self selector:@selector(animation1) userInfo:nil repeats:YES];
    
    
    self.backgroundColor = [UIColor clearColor];
    UIButton * scanButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [scanButton setTitle:@"取消" forState:UIControlStateNormal];
    [scanButton setTintColor:[UIColor whiteColor]];
    [scanButton setBackgroundColor:[UIColor BtnBgColor]];
    scanButton.frame = CGRectMake(labIntroudction.frame.origin.x, 420, 120, 40);
    scanButton.layer.cornerRadius = 4;
    [scanButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:scanButton];
    
    UIButton * ptoButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [ptoButton setTitle:@"相册" forState:UIControlStateNormal];
    [ptoButton setTintColor:[UIColor whiteColor]];
    [ptoButton setBackgroundColor:[UIColor BtnBgColor]];
    ptoButton.frame = CGRectMake(labIntroudction.frame.origin.x +labIntroudction.frame.size.width - 120, 420, 120, 40);
    ptoButton.layer.cornerRadius = 4;
    [ptoButton addTarget:self action:@selector(phoOverlayView:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:ptoButton];


    
}

-(void)animation1
{
    if (upOrdown == NO) {
        num ++;
        _line.frame = CGRectMake((kScreenWidth-220)/2, 110+2*num, 220, 2);
        if (2*num == 280) {
            upOrdown = YES;
        }
    }
    else {
        num --;
        _line.frame = CGRectMake((kScreenWidth-220)/2, 110+2*num, 220, 2);
        if (num == 0) {
            upOrdown = NO;
        }
    }
    
}
#pragma mark - 点击返回
-(void)backAction
{
    [timer invalidate];
    
    if ([_myDelegate respondsToSelector:@selector(backAction)])
    {
        [_myDelegate backAction];
    }
    
}

#pragma mark - 点击相册
-(void)phoOverlayView:(id)sender{
    
    if ([_myDelegate respondsToSelector:@selector(openPhotoAlbum)])
    {
        [_myDelegate openPhotoAlbum];
    }
}

-(void)stopTimer{

    [timer invalidate];
    
}

/**
 * 可视范围
 */
-(CGRect )previewframe{
    CGRect prframe = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    return   prframe;
}

@end
