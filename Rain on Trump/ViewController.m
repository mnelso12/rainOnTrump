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
    BOOL move = YES;
    
    //NSLog(@"trumpState = %i", trumpState);
    //NSLog(@"hillary array size: %lu", [hillaries count]);
    //NSLog(@"hillary states: %@", [hillaryStates description]);
    
    for (int i=0; i<[hillaries count]; i++)
    {
        // watch for collisions
        UIImageView *iv = [hillaries objectAtIndex:i];
      
        //if (CGRectIntersectsRect(iv.frame, trump.frame)) // collision, make/keep fire and count fire
        if (CGRectIntersectsRect(iv.frame, trumpOutline1.frame) || CGRectIntersectsRect(iv.frame, trumpOutline2.frame) || CGRectIntersectsRect(iv.frame, trumpOutline3.frame))
        {
            
            
            NSNumber *prevState = [hillaryStates objectAtIndex:i];
            int prevStateInt = [prevState intValue];
            prevStateInt++;
            //NSLog(@"prev state part: %i", prevStateInt);
            //NSLog(@"2 in nsnumber form: %@", [NSNumber numberWithInt:2]);
            if (prevStateInt == 1)
            {
                //NSLog(@"playing sound!");
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
            
            NSLog(@"perv state int = %i", prevStateInt);
            if (prevStateInt < 10)
            {
                [iv setImage:[UIImage imageNamed:@"drawing7-1.png"]];
                move = NO;
            }
            else if (prevStateInt < 20)
            {
                [iv setImage:[UIImage imageNamed:@"drawing8-1.png"]];
                move = NO;
            }
            else if (prevStateInt < 30)
            {
                [iv setImage:[UIImage imageNamed:@"drawing9-1.png"]];
                move = NO;
            }
            else if (prevStateInt < 40)
            {
                [iv setImage:[UIImage imageNamed:@"drawing5-1.png"]];
                move = NO;
            }
            else if (prevStateInt < 50)
            {
                [iv setImage:[UIImage imageNamed:@"drawing6-1.png"]];
                move = NO;
            }
            else if (prevStateInt < 1000)
            {
                [iv setImage:[UIImage imageNamed:@"empty"]];
                move = YES;
            }

            
            /*
            //NSLog(@"perv state int = %i", prevStateInt);
            if (prevStateInt < 9)
            {
                [iv setImage:[UIImage imageNamed:@"fire4-flipped-big.png"]];
            }
            else if (prevStateInt < 18)
            {
                [iv setImage:[UIImage imageNamed:@"fire4.png"]];
            }
            else if (prevStateInt < 27)
            {
                [iv setImage:[UIImage imageNamed:@"fire6.png"]];
            }
            else if (prevStateInt < 36)
            {
                [iv setImage:[UIImage imageNamed:@"fire6-flipped.png"]];
            }
            else if (prevStateInt < 45)
            {
                [iv setImage:[UIImage imageNamed:@"fire4-flipped-big.png"]];
            }
            else if (prevStateInt < 54)
            {
                [iv setImage:[UIImage imageNamed:@"fire4.png"]];
            }
            else if (prevStateInt < 63)
            {
                [iv setImage:[UIImage imageNamed:@"fire6.png"]];
            }
            else if (prevStateInt < 72)
            {
                [iv setImage:[UIImage imageNamed:@"fire6-flipped.png"]];
            }
            else if (prevStateInt < 81)
            {
                [iv setImage:[UIImage imageNamed:@"fire4-flipped-big.png"]];
            }
            else if (prevStateInt < 90)
            {
                [iv setImage:[UIImage imageNamed:@"fire4.png"]];
            }
            else if (prevStateInt < 99)
            {
                [iv setImage:[UIImage imageNamed:@"fire6.png"]];
            }
            else if (prevStateInt < 108)
            {
                [iv setImage:[UIImage imageNamed:@"fire6-flipped.png"]];
            }

*/
            
            [hillaryStates setObject:[NSNumber numberWithInt:prevStateInt] atIndexedSubscript:i];
            trumpState = 1;
            
            //NSLog(@"Collision");
        }
        //else if ([[hillaryStates objectAtIndex:i] intValue] >= 3) // when fire goes out
        if (CGRectIntersectsRect(iv.frame, adFrame.frame))
        {
            //NSLog(@"fire goes out, removing from hillaries array");
            iv.hidden = YES;
            
            [toUpdate addObject:[NSNumber numberWithInt:i]];
        }
        
        if (move)
        {
            CGPoint oldCenter = iv.center;
            [iv setCenter:CGPointMake(oldCenter.x, oldCenter.y+2)];
        }
        else
        {
            CGPoint oldCenter = iv.center;
            [iv setCenter:CGPointMake(oldCenter.x, oldCenter.y+2)];
        }
        
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
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if (motion == UIEventSubtypeMotionShake)
    {
        AudioServicesPlaySystemSound(china1);
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    UITouch *myTouch = [[event allTouches] anyObject];
    
    NSString *imageName;
    int randNum = arc4random_uniform(10);
    //NSLog(@"randNum = %i", randNum);
    if ( randNum % 2 == 0)
    {
        imageName = @"kellyDrop.png";
    }
    else
    {
        imageName = @"hillaryDrop.png";
    }
    
    UIImageView *tempHillary = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
    [tempHillary setFrame:CGRectMake(0, 0, 50, 65)];
    [tempHillary setCenter:CGPointMake([myTouch locationInView:self.view].x, 60)];
    [tempHillary setContentMode:UIViewContentModeScaleAspectFit];
    [self.view addSubview:tempHillary];
    [self.view bringSubviewToFront:tempHillary];
    
    [hillaries addObject:tempHillary];
    [hillaryStates addObject:[NSNumber numberWithInt:0]]; // 0 = hillary, 1 = collision/fire, >5 = hidden
    [self.view bringSubviewToFront:cloud];
    
    count++;
    [countLabel setText:[NSString stringWithFormat:@"%i",count]];
    
    [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%i", count] forKey:@"score"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [self.view addSubview:countLabel];
    [self.view bringSubviewToFront:countLabel];
    
    [self applyHillarySize];
}

- (void)makeHillaryBigger
{
    sizeTimer = [NSTimer scheduledTimerWithTimeInterval:.2 target:self selector:@selector(increaseHillarySize) userInfo:nil repeats:YES];
}

- (void)increaseHillarySize
{
    if (hillaryScale < 2.75) // cap because Ryan broke it
    {
        hillaryScale += .25;
    }
}

- (void)applyHillarySize
{
    UIImageView *iv = [hillaries objectAtIndex:[hillaries count]-1]; // got last hillary
    CGPoint oldCenter = iv.center;
    [iv setFrame:CGRectMake(oldCenter.x, oldCenter.y, hillaryScale*50, hillaryScale*65)];
    hillaryScale = 1.;
    [sizeTimer invalidate];

}

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
    
    
    
    trumpState = 0;
    hillaryScale = 1.;
    hillaries = [[NSMutableArray alloc] initWithObjects: nil];
    hillaryStates = [[NSMutableArray alloc] initWithObjects: nil];
    timer = [NSTimer scheduledTimerWithTimeInterval:.01 target:self selector:@selector(collision) userInfo:nil repeats:YES];
    
    
    
    // put uiimageviews in right spots
    
    CGSize screenSize      = [[UIScreen mainScreen] bounds].size;
    CGFloat widthOfScreen  = screenSize.width;
    CGFloat heightOfScreen = screenSize.height;
    cloud = [[UIImageView alloc] initWithFrame:CGRectMake(0, 20, widthOfScreen, 100)];
    [cloud setImage:[UIImage imageNamed:@"cloud1.png"]];
    
    countLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 40, widthOfScreen, 60)];
    [countLabel setFont:[UIFont fontWithName:@"Verdana" size:32]];
    [countLabel setTextColor:[UIColor whiteColor]];
    [countLabel setTextAlignment:NSTextAlignmentCenter];
    
    [self.view addSubview:cloud];
    [self.view addSubview:countLabel];
    //[self.view bringSubviewToFront:cloud];
    [self.view bringSubviewToFront:countLabel];
    
    float trumpRatio = 270./375.; // height/width
    
    trump = [[UIImageView alloc] initWithFrame:CGRectMake(0, heightOfScreen-50-trumpRatio*widthOfScreen, widthOfScreen, trumpRatio*widthOfScreen)];
    //trump = [[UIImageView alloc] initWithFrame:CGRectMake(0, heightOfScreen-trumpRatio*widthOfScreen, widthOfScreen, trumpRatio*widthOfScreen)];
    [self.view addSubview:trump];
    
    
    // make trump outline uiviews
    
    
    trumpOutline1 = [[UIView alloc] initWithFrame:CGRectMake(0, heightOfScreen-50-trumpRatio*widthOfScreen*.38, widthOfScreen*.5, trumpRatio*widthOfScreen*.38)]; // left shoulder
    trumpOutline3 = [[UIView alloc] initWithFrame:CGRectMake(widthOfScreen*.5, heightOfScreen-50-trumpRatio*widthOfScreen*.28, widthOfScreen*.5, trumpRatio*widthOfScreen*.28)]; // right shoulder
    trumpOutline2 = [[UIView alloc] initWithFrame:CGRectMake(widthOfScreen*.5 - 60, heightOfScreen-50-trumpRatio*widthOfScreen, 120, trumpRatio*widthOfScreen*.5)]; // head
    
    /*
    trumpOutline1 = [[UIView alloc] initWithFrame:CGRectMake(0, heightOfScreen-trumpRatio*widthOfScreen*.38, widthOfScreen*.5, trumpRatio*widthOfScreen*.38)]; // left shoulder
    trumpOutline3 = [[UIView alloc] initWithFrame:CGRectMake(widthOfScreen*.5, heightOfScreen-trumpRatio*widthOfScreen*.28, widthOfScreen*.5, trumpRatio*widthOfScreen*.28)]; // right shoulder
    trumpOutline2 = [[UIView alloc] initWithFrame:CGRectMake(widthOfScreen*.5 - 60, heightOfScreen-trumpRatio*widthOfScreen, 120, trumpRatio*widthOfScreen*.5)]; // head
     */
    [self.view addSubview:trumpOutline1];
    [self.view addSubview:trumpOutline2];
    [self.view addSubview:trumpOutline3];
    
    
    // make count label work
    
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
    

}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self becomeFirstResponder];
    
    adFrame = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height-50, self.view.frame.size.width, 50)];
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

- (void)viewWillDisappear:(BOOL)animated {
    [self resignFirstResponder];
    [super viewWillDisappear:animated];
}

-(BOOL)canBecomeFirstResponder {
    return YES;
}



@end
