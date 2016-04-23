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
#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<ADBannerViewDelegate, UIAlertViewDelegate>
{
    int count;
    IBOutlet UILabel *countLabel;
    
    IBOutlet UIImageView *trump;
    IBOutlet UIImageView *cloud;
    
    UIView *trumpOutline1;
    UIView *trumpOutline2;
    UIView *trumpOutline3;
    
    UIView *adFrame;
    
    UIView *leaderboard;
    UILabel *leaderboardTitle;
    UILabel *leaderboardTotal;
    UILabel *leaderboardShareLabel;
    IBOutlet UIButton *leaderboardButton;
    NSMutableArray *leaders;
    NSMutableArray *leaderScores;
    IBOutlet UIButton *fb;
    BOOL isPaused;
    
    int trumpState; 
    
    NSMutableArray *hillaries;
    NSMutableArray *hillaryStates;
    
    NSTimer *timer;
    NSTimer *sizeTimer;

    float hillaryScale;
    CGFloat sw, sh;

}


@end

