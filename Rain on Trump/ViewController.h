//
//  ViewController.h
//  Rain on Trump
//
//  Created by MadelynNelson on 3/31/16.
//  Copyright (c) 2016 Madelyn Nelson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>
#import <iAd/iAd.h>

@interface ViewController : UIViewController<ADBannerViewDelegate>
{
    int count;
    IBOutlet UILabel *countLabel;
    
    IBOutlet UIImageView *trump;
    IBOutlet UIImageView *cloud;
    
    UIView *trumpOutline1;
    UIView *trumpOutline2;
    UIView *trumpOutline3;
    
    UIView *adFrame;
    
    int trumpState; 
    
    NSMutableArray *hillaries;
    NSMutableArray *hillaryStates;
    
    NSTimer *timer;
    NSTimer *sizeTimer;

    float hillaryScale;
    
    SystemSoundID idc;
    SystemSoundID highlyInappropriate;
    SystemSoundID grunt1;
    SystemSoundID grunt2;
    SystemSoundID sound1;
    SystemSoundID sound2;
    SystemSoundID sound3;
    SystemSoundID china1;

    
}


@end

