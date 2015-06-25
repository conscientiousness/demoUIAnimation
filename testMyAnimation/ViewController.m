//
//  ViewController.m
//  testMyAnimation
//
//  Created by Jesselin on 2015/6/17.
//  Copyright (c) 2015年 Jesse. All rights reserved.
//

#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIView *theYellowView;
@property (weak, nonatomic) IBOutlet UIView *theGreenView;
@property (weak, nonatomic) IBOutlet UIImageView *theImageView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //所佔記憶體:500*500*4bytes
    NSArray *images = @[[UIImage imageNamed:@"cat1.jpg"],
                       [UIImage imageNamed:@"cat2.jpg"],
                       [UIImage imageNamed:@"cat3.jpg"]];
    
    _theImageView.contentMode = UIViewContentModeScaleAspectFit;
    _theImageView.animationImages = images;
    _theImageView.animationRepeatCount = 0;
    
    //跑一輪所需時間
    _theImageView.animationDuration = 3.0;
    [_theImageView startAnimating];
    
}
- (IBAction)theSwitch1BtnPressed:(id)sender {
    
    //名稱與下方cache搭配
    [UIView beginAnimations:@"animation1" context:nil];
    
    [UIView setAnimationDuration:1.5];
    //UIViewAnimationCurveEaseInOut
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:_theYellowView cache:YES];
    
    //移動到畫面外面隱藏和顯示回來
    //取得_theYellowView寬高
    CGRect frame = _theYellowView.frame;
    
    if(frame.origin.y<0){//目前不在畫面上，要移回來
        frame.origin.y = 0;
    }else{//目前在畫面上，要移出去畫面外
        frame.origin.y -= frame.size.height;
    }
    
    _theYellowView.frame = frame;
    
    [UIView commitAnimations];
}

//Use QC framework
- (IBAction)theSwitch2BtnPressed:(id)sender {
    
    CATransition *transition = [CATransition animation];
    transition.duration = 1.5;
    
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    transition.type =kCATransitionPush;
    
    if(_theGreenView.isHidden) {
        _theGreenView.hidden = NO;
        //動畫的方向
        transition.subtype = kCATransitionFromLeft;
    }else{
        _theGreenView.hidden =YES;
        transition.subtype = kCATransitionFromRight;
    }
    
    //layer:UI元件，比UIView更底層，動畫效果使用 CAlayer
    [_theGreenView.layer addAnimation:transition forKey:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
