//
//  ScanQRCode.m
//  LBZBar
//
//  Created by kingly on 15/12/17.
//  Copyright © 2015年 kingly. All rights reserved.
//

#import "ScanQRCode.h"

#import "ZBarSDK.h"
#import "QRCodeGenerator.h"

#if TARGET_IPHONE_SIMULATOR
#define SIMULATOR 1
#elif TARGET_OS_IPHONE
#define SIMULATOR 0
#endif


#define kScreenWidth ([[UIScreen mainScreen]bounds].size.width)//屏幕宽度
#define kScreenHeight ([[UIScreen mainScreen]bounds].size.height > [[UIScreen mainScreen]bounds].size.width?[[UIScreen mainScreen]bounds].size.height:[[UIScreen mainScreen]bounds].size.width)//屏幕高度

@interface ScanQRCode ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate,ZBarReaderDelegate,ScanQRCodeViewDelegate>

   

@end

@implementation ScanQRCode

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setInitUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
/**
 * 初始化UI
 **/
-(void)setInitUI{

    _scanView = [[ScanQRCodeView alloc] init];
    _scanView.myDelegate = self;
    _scanView.frame = CGRectMake(0, 0,kScreenWidth, kScreenHeight);
    [self.view addSubview:_scanView];

}

-(void)viewWillAppear:(BOOL)animated
{
    if (SIMULATOR) {
        NSLog(@"注意：该二维码扫描功能需要在真机上才能正常使用！");
    }else{
        [self setupCamera];
        
    }
}


- (void)setupCamera
{
    // Device
    _device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    // Input
    _input = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:nil];
    
    // Output
    _output = [[AVCaptureMetadataOutput alloc]init];
    [_output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    // Session
    _session = [[AVCaptureSession alloc]init];
    [_session setSessionPreset:AVCaptureSessionPresetHigh];
    if ([_session canAddInput:self.input])
    {
        [_session addInput:self.input];
    }
    
    if ([_session canAddOutput:self.output])
    {
        [_session addOutput:self.output];
    }
    
    // 条码类型 AVMetadataObjectTypeQRCode
    _output.metadataObjectTypes =@[AVMetadataObjectTypeQRCode];
    
    // Preview
    _preview =[AVCaptureVideoPreviewLayer layerWithSession:self.session];
    _preview.videoGravity = AVLayerVideoGravityResizeAspectFill;
    _preview.frame = [_scanView previewframe];
    [self.view.layer insertSublayer:self.preview atIndex:0];
    
    
    
    // Start
    [_session startRunning];
}
#pragma mark AVCaptureMetadataOutputObjectsDelegate
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    NSString *stringValue;
    if ([metadataObjects count] >0)
    {
        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex:0];
        stringValue = metadataObject.stringValue;
        
        if ([_delegate respondsToSelector:@selector(captureQRCode:)])
        {
            [_delegate captureQRCode:stringValue];
        }
    }
    
    [_session stopRunning];
    [self dismissViewControllerAnimated:YES completion:^
     {
         [_scanView stopTimer];
      
     }];
}


#pragma mark -  ZBarReaderDelegate
- (void) imagePickerController:(UIImagePickerController*) picker
 didFinishPickingMediaWithInfo:(NSDictionary *) info
{
    [picker dismissViewControllerAnimated:YES completion:^{
        [picker removeFromParentViewController];
        
        UIImage * image = [info objectForKey:UIImagePickerControllerOriginalImage];
        //初始化
        ZBarReaderController * read = [ZBarReaderController new];
        //设置代理
        read.readerDelegate = self;
        CGImageRef cgImageRef = image.CGImage;
        ZBarSymbol * symbol = nil;
        id <NSFastEnumeration> results = [read scanImage:cgImageRef];
        for (symbol in results)
        {
            break;
        }
        NSString * result;
        if ([symbol.data canBeConvertedToEncoding:NSShiftJISStringEncoding])
            
        {
            result = [NSString stringWithCString:[symbol.data cStringUsingEncoding: NSShiftJISStringEncoding] encoding:NSUTF8StringEncoding];
        }
        else
        {
            result = symbol.data;
        }
        
        
        [_session stopRunning];
        [self dismissViewControllerAnimated:NO completion:^{
             [_scanView stopTimer];
            
            if ([_delegate respondsToSelector:@selector(captureQRCode:)])
            {
                [_delegate captureQRCode:result];
            }
            
            
            
        }];
        
        
    }];
    
}

//取消选择
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - ScanningViewDelegate
/**
 * 点击相册扫描
 */
-(void)photoScan{
    
    UIImagePickerController *pickerImage = [[UIImagePickerController alloc] init];
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        pickerImage.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        pickerImage.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:pickerImage.sourceType];
        
    }
    pickerImage.delegate = self;
    pickerImage.allowsEditing = NO;
    pickerImage.navigationBar.barStyle = UIBarStyleDefault;
    [self presentViewController:pickerImage animated:YES completion:^{}];
}


#pragma mark - ScanningViewDelegate
/**
 * 点击返回
 */
-(void)backAction{
    
    [self dismissViewControllerAnimated:YES completion:^{
          [_scanView stopTimer];
     }];
}
/**
 * 打开相册，读取扫描相片，读取二维码数据
 */
-(void)openPhotoAlbum{
  [self photoScan];
}

@end
