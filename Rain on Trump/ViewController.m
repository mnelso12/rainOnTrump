//
//  ViewController.m
//  Rain on Trump
//
//  Created by MadelynNelson on 3/31/16.
//  Copyright (c) 2016 Madelyn Nelson. All rights reserved.
//

#import "ViewController.h"
#import <AudioToolbox/AudioToolbox.h>
#import <stdlib.h> // since when does this exist
#import <math.h>

@interface ViewController ()
{
    BOOL _bannerIsVisible;
    ADBannerView *_adBanner;
}

@end

@implementation ViewController

- (void)collision
{
    NSMutableArray *toUpdate = [[NSMutableArray alloc] init];
    
    //NSLog(@"trumpState = %i", trumpState);
    
    //NSLog(@"hillary array size: %lu", [hillaries count]);
    int oldCount = (int)[hillaries count];
    
    for (int i=0; i<[hillaries count]; i++)
    {
        if ([hillaries count] != oldCount)
        {
            NSLog(@"COUNT IS CHANGING! old: %i, new: %lu", oldCount, [hillaries count]);
        }
        
        // watch for collisions
        UIImageView *iv = [hillaries objectAtIndex:i];
      
        //if ([self pointInside:CGPointMake(iv.center.x, iv.center.y)] == YES)
        if (CGRectIntersectsRect(iv.frame, trump.frame)) // collision, make/keep fire and count fire
        {
            [iv setImage:[UIImage imageNamed:@"fire2.jpg"]];
            NSNumber *prevState = [hillaryStates objectAtIndex:i];
            int prevStateInt = [prevState intValue];
            prevStateInt++;
            //NSLog(@"prev state part: %i", prevStateInt);
            //NSLog(@"2 in nsnumber form: %@", [NSNumber numberWithInt:2]);
            if (prevStateInt == 1)
            {
                NSLog(@"playing sound!");
                int randNum = arc4random_uniform(100);
                if (randNum > 60)
                {
                   AudioServicesPlaySystemSound(grunt1); // short and high
                }
                else if (randNum > 40)
                {
                    //AudioServicesPlaySystemSound(grunt2); // lower
                    AudioServicesPlaySystemSound(sound3); // two noises, kinda low
                }
                else if (randNum > 15)
                {
                    //AudioServicesPlaySystemSound(sound2); // two noises
                    AudioServicesPlaySystemSound(sound1); // good one
                }
                else
                {
                    AudioServicesPlaySystemSound(china1);
                }
                    
                
            }
            [hillaryStates setObject:[NSNumber numberWithInt:prevStateInt] atIndexedSubscript:i];
            trumpState = 1;
            
            
            //AudioServicesPlaySystemSound(grunt1);
            //NSLog(@"Collision");
        }
        else if ((int)[hillaryStates objectAtIndex:i] >= 3) // when fire goes out
        {
            //NSLog(@"fire goes out, removing from hillaries array");
            iv.hidden = YES;
            
            [toUpdate addObject:[NSNumber numberWithInt:i]];
        }
        
        // make them fall
        CGPoint oldCenter = iv.center;
        [iv setCenter:CGPointMake(oldCenter.x, oldCenter.y+3)];
    }
    
    
    if (trumpState >= 1)
    {
        trumpState++;
    }
 
    
    [self.view bringSubviewToFront:trump];
    
    if ((int)[toUpdate count] > 0)
    {
        for (NSNumber *n in toUpdate)
        {
            [self updateHillaryArr:[n intValue]];
        }
    }
    
    [self updateTrump];
    [self.view bringSubviewToFront:_adBanner];
}

- (void)updateTrump
{
    if (trumpState == 0 || trumpState > 14)
    {
        trumpState = 0;
        [trump setImage:[UIImage imageNamed:@"trump11.png"]];
    }
    else
    {
        [trump setImage:[UIImage imageNamed:@"trump10.png"]];
    }
}

- (void)updateHillaryArr:(int)index
{
    //NSLog(@"before update: %@, index = %i", [hillaries description], index);
    
    NSMutableArray *tempHillaries = [[NSMutableArray alloc] init];
    NSMutableArray *tempHillaryStates = [[NSMutableArray alloc] init];
    for (int i=0; i<[hillaries count]; i++)
    {
        if (i != index)
        {
            [tempHillaries addObject:[hillaries objectAtIndex:i]];
            [tempHillaryStates addObject:[hillaryStates objectAtIndex:i]];
        }
    }
    
    [hillaries removeAllObjects];
    [hillaryStates removeAllObjects];
    
    for (int i=0; i<[tempHillaries count]; i++)
    {
        [hillaries addObject:[tempHillaries objectAtIndex:i]];
        [hillaryStates addObject:[tempHillaryStates objectAtIndex:i]];
    }
    
    //NSLog(@"after update: %@", [hillaries description]);
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self makeHillaryBigger];
    
    /*
    UITouch *myTouch = [[event allTouches] anyObject];
    
    UIImageView *tempHillary = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"hillary1.jpg"]];
    [tempHillary setFrame:CGRectMake(0, 0, 30, 30)];
    [tempHillary setCenter:CGPointMake([myTouch locationInView:self.view].x, 0)];
    [self.view addSubview:tempHillary];
    
    [hillaries addObject:tempHillary];
    [self makeHillaryBigger];
     */
    
    //hillary.center = [myTouch locationInView:self.view];
}


- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    UITouch *myTouch = [[event allTouches] anyObject];
    
    NSString *imageName;
    int randNum = arc4random_uniform(10);
    NSLog(@"randNum = %i", randNum);
    if ( randNum % 2 == 0)
    {
        imageName = @"hillary1.jpg";
    }
    else
    {
        imageName = @"kelly1.jpg";
    }
    
    UIImageView *tempHillary = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
    [tempHillary setFrame:CGRectMake(0, 0, 30, 30)];
    [tempHillary setCenter:CGPointMake([myTouch locationInView:self.view].x, 60)];
    [self.view addSubview:tempHillary];
    
    [hillaries addObject:tempHillary];
    [hillaryStates addObject:[NSNumber numberWithInt:0]]; // 0 = hillary, 1 = collision/fire, >5 = hidden
    [self.view bringSubviewToFront:cloud];
    
    count++;
    [countLabel setText:[NSString stringWithFormat:@"%i",count]];
    
    [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%i", count] forKey:@"score"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [self.view addSubview:countLabel];
    [self.view bringSubviewToFront:countLabel];
    
    //hillary.center = [myTouch locationInView:self.view];
    [self applyHillarySize];
}

- (void)makeHillaryBigger
{
    sizeTimer = [NSTimer scheduledTimerWithTimeInterval:.2 target:self selector:@selector(increaseHillarySize) userInfo:nil repeats:YES];
}

- (void)increaseHillarySize
{
    hillaryScale += 25.;
}

- (void)applyHillarySize
{
    UIImageView *iv = [hillaries objectAtIndex:[hillaries count]-1]; // got last hillary
    CGPoint oldCenter = iv.center;
    [iv setFrame:CGRectMake(oldCenter.x, oldCenter.y, hillaryScale+30, hillaryScale+30)];
    hillaryScale = 1.;
    [sizeTimer invalidate];

}

/*
- (BOOL)pointInside:(CGPoint)point
{
    //Using code from http://stackoverflow.com/questions/1042830/retrieving-a-pixel-alpha-value-for-a-uiimage
    
    unsigned char pixel[1] = {0};
    CGContextRef context = CGBitmapContextCreate(pixel,
                                                 1, 1, 8, 1, NULL,
                                                 kCGImageAlphaOnly);
    UIGraphicsPushContext(context);
    [[UIImage imageNamed:@"trump10.png"] drawAtPoint:CGPointMake(-point.x, -point.y)];
    UIGraphicsPopContext();
    CGContextRelease(context);
    CGFloat alpha = pixel[0]/255.0f;
    BOOL transparent = alpha < 0.01f;
    
    NSLog(@"transparent? : %d", !transparent);
    
    return !transparent;
}
*/

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self.view setBackgroundColor:[UIColor blackColor]];
    
    NSString *soundPath0 = [[NSBundle mainBundle] pathForResource:@"china" ofType:@"wav"];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath: soundPath0], &(china1));
    NSString *soundPath1 = [[NSBundle mainBundle] pathForResource:@"grunt1" ofType:@"wav"];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath: soundPath1], &(grunt1));
    NSString *soundPath2 = [[NSBundle mainBundle] pathForResource:@"grunt2-2" ofType:@"wav"];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath: soundPath2], &(grunt2));
    NSString *soundPath3 = [[NSBundle mainBundle] pathForResource:@"smallSound1" ofType:@"wav"];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath: soundPath3], &(sound1));
    NSString *soundPath4 = [[NSBundle mainBundle] pathForResource:@"smallSound2" ofType:@"wav"];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath: soundPath4], &(sound2));
    NSString *soundPath5 = [[NSBundle mainBundle] pathForResource:@"smallSound3" ofType:@"wav"];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath: soundPath5], &(sound3));
    
    
    if (![[NSUserDefaults standardUserDefaults] stringForKey:@"score"])
    {
        [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"score"];
        [countLabel setText:@"0"];
        count = 0;
    }
    else
    {
        count = [[[NSUserDefaults standardUserDefaults] stringForKey:@"score"] intValue];
        [countLabel setText:[NSString stringWithFormat:@"%i", count]];
    }

    CGSize screenSize      = [[UIScreen mainScreen] bounds].size;
    CGFloat widthOfScreen  = screenSize.width;
    CGFloat heightOfScreen = screenSize.height;
    [cloud setFrame:CGRectMake(0, 0, widthOfScreen, 0)];
    
    trumpState = 0;
    hillaryScale = 1.;
    hillaries = [[NSMutableArray alloc] initWithObjects: nil];
    hillaryStates = [[NSMutableArray alloc] initWithObjects: nil];
    timer = [NSTimer scheduledTimerWithTimeInterval:.01 target:self selector:@selector(collision) userInfo:nil repeats:YES];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    _adBanner = [[ADBannerView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height, 320, 50)];
    _adBanner.delegate = self;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)bannerViewDidLoadAd:(ADBannerView *)banner
{
    NSLog(@"ad loaded");
    if (!_bannerIsVisible)
    {
        // If banner isn't part of view hierarchy, add it
        if (_adBanner.superview == nil)
        {
            [self.view addSubview:_adBanner];
        }
        
        [UIView beginAnimations:@"animateAdBannerOn" context:NULL];
        
        // Assumes the banner view is just off the bottom of the screen.
        banner.frame = CGRectOffset(banner.frame, 0, -banner.frame.size.height);
        
        [UIView commitAnimations];
        
        _bannerIsVisible = YES;
    }
}

- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error
{
    NSLog(@"Failed to retrieve ad");
    
    if (_bannerIsVisible)
    {
        [UIView beginAnimations:@"animateAdBannerOff" context:NULL];
        
        // Assumes the banner view is placed at the bottom of the screen.
        banner.frame = CGRectOffset(banner.frame, 0, banner.frame.size.height);
        
        [UIView commitAnimations];
        
        _bannerIsVisible = NO;
    }
}


@end
