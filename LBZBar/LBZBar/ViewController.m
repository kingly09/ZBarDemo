//
//  ViewController.m
//  LBZBar
//
//  Created by kingly on 15/12/16.
//  Copyright © 2015年 kingly. All rights reserved.
//

#import "ViewController.h"

//#import "ZBarSDK.h"
//#import "QRCodeGenerator.h"
//#import "ScanQRCode_VC.h"
//
//
//@interface ViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate,ScanQRCodeVCDelegate,ZBarReaderDelegate>
//
//@end

#import "ScanQRCode.h"

@interface ViewController ()<ScanQRCodeVCDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - 使用二维码添加
//-(void)showScanningView{
//    ScanQRCode_VC * scanVC = [[ScanQRCode_VC alloc] init];
//    scanVC.delegate = self;
//    [self presentViewController:scanVC animated:YES completion:nil];
//}
//#pragma mark -  ZBarReaderDelegate
//- (void) imagePickerController:(UIImagePickerController*) picker
// didFinishPickingMediaWithInfo:(NSDictionary *) info
//{
//    [picker dismissViewControllerAnimated:YES completion:^{
//        [picker removeFromParentViewController];
//        
//        UIImage * image = [info objectForKey:UIImagePickerControllerOriginalImage];
//        //初始化
//        ZBarReaderController * read = [ZBarReaderController new];
//        //设置代理
//        read.readerDelegate = self;
//        CGImageRef cgImageRef = image.CGImage;
//        ZBarSymbol * symbol = nil;
//        id <NSFastEnumeration> results = [read scanImage:cgImageRef];
//        for (symbol in results)
//        {
//            break;
//        }
//        NSString * result;
//        if ([symbol.data canBeConvertedToEncoding:NSShiftJISStringEncoding])
//            
//        {
//            result = [NSString stringWithCString:[symbol.data cStringUsingEncoding: NSShiftJISStringEncoding] encoding:NSUTF8StringEncoding];
//        }
//        else
//        {
//            result = symbol.data;
//        }
//        
//        if (result.length == 0) {
//            
//            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:nil message:@"扫描到的数据有误，请重试!"delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:Nil, nil];
//            [alertView show];
//            return;
//            
//        }
//        
//         NSLog(@"二维码相册扫描：%@",result);
//        
//    }];
//    
//}
//
////取消选择
//- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
//{
//    [self dismissViewControllerAnimated:YES completion:nil];
//}


#pragma mark - ScanningViewDelegate
///**
// * 点击相册扫描
// */
//-(void)photoScan{
//    
//    UIImagePickerController *pickerImage = [[UIImagePickerController alloc] init];
//    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
//        pickerImage.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
//        pickerImage.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:pickerImage.sourceType];
//        
//    }
//    pickerImage.delegate = self;
//    pickerImage.allowsEditing = NO;
//    pickerImage.navigationBar.barStyle = UIBarStyleDefault;
//    [self presentViewController:pickerImage animated:YES completion:^{}];
//    
//}

-(void)showScanningView{

        ScanQRCode * scanVC = [[ScanQRCode alloc] init];
        scanVC.delegate = self;
        [self presentViewController:scanVC animated:YES completion:nil];
}
/**
 * 点击二维码扫描
 **/
- (void) captureQRCode:(NSString*)code
{
    NSLog(@"二维码扫描：%@",code);
    
    if (code.length == 0) {
        
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:nil message:@"扫描到的数据有误，请重试!" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:Nil, nil];
        [alertView show];
        return;
        
        
    }
 
    
}





/**
 * 点击 扫一扫
 */
- (IBAction)onClickShaoMiao:(id)sender {
    
    [self showScanningView];
}
@end
