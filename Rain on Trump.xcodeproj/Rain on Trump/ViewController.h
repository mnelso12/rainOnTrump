//
//  ViewController.h
//  Rain on Trump
//
//  Created by MadelynNelson on 3/31/16.
//  Copyright (c) 2016 Madelyn Nelson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
{
    IBOutlet UIImageView *trump;
    //IBOutlet UIImageView *hillary;
    IBOutlet UIImageView *cloud;
    
    NSMutableArray *hillaries;
    
    NSTimer *timer;
    NSTimer *sizeTimer;

    float hillaryScale;
}


@end

