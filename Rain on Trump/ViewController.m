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
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>
#import <UIKit/UIKit.h>
#import <Firebase/Firebase.h>
#import <Foundation/Foundation.h>
#import <SystemConfiguration/SystemConfiguration.h>
#import <sys/socket.h>
#import <netinet/in.h>
#import "Reachability.h"


@interface ViewController ()
{
    BOOL _bannerIsVisible;
    ADBannerView *_adBanner;
    AVAudioPlayer *water;
    AVAudioPlayer *china;
    AVAudioPlayer *china_;
    AVAudioPlayer *china4;
    AVAudioPlayer *idc;
    AVAudioPlayer *wall1;
    AVAudioPlayer *highlyInapropriate;
    AVAudioPlayer *cutGovtSpending;
    AVAudioPlayer *itsGoingToEnd;
    AVAudioPlayer *imReallyRich;
    AVAudioPlayer *outOfControl;
}

@end

@implementation ViewController

- (void)collision
{
    if (isPaused)
    {
        return;
    }
    
    NSMutableArray *toUpdate = [[NSMutableArray alloc] init];
    BOOL move = YES;
    
    //NSLog(@"trumpState = %i", trumpState);
    //NSLog(@"hillary array size: %lu", (unsigned long)[hillaries count]);
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
                [water play];
                //NSLog(@"playing sound!");
                int randNum = arc4random_uniform(100);
                if (randNum > 90)
                {
                    //AudioServicesPlaySystemSound(grunt1); // short and high
                    //AudioServicesPlaySystemSound(idc);
                    //AudioServicesPlaySystemSound(china4);
                    [china4 play];
                }
                else if (randNum > 80)
                {
                    //AudioServicesPlaySystemSound(idc);
                    [idc play];
                }
                else if (randNum > 70)
                {
                    ////////////////AudioServicesPlaySystemSound(grunt2); // lower
                    //AudioServicesPlaySystemSound(sound3); // two noises, kinda low
                    //AudioServicesPlaySystemSound(china1);
                    [china play];
                }
                else if (randNum > 60)
                {
                    ////////////AudioServicesPlaySystemSound(sound2); // two noises
                    //AudioServicesPlaySystemSound(sound1); // good one
                    //AudioServicesPlaySystemSound(highlyInappropriate);
                    //AudioServicesPlaySystemSound(china_);
                    [china_ play];
                }
                else if (randNum > 50)
                {
                    //AudioServicesPlaySystemSound(highlyInappropriate);
                    [highlyInapropriate play];
                }
                else if (randNum > 40)
                {
                    [imReallyRich play];
                }
                else if (randNum > 30)
                {
                    [itsGoingToEnd play];
                }
                else if (randNum > 20)
                {
                    [cutGovtSpending play];
                }
                else if (randNum > 10)
                {
                    [outOfControl play];
                }
                else
                {
                    //AudioServicesPlaySystemSound(wall);
                    [wall1 play];
                }
                //AudioServicesPlaySystemSound(water);
            }
            
            //NSLog(@"prev state int = %i", prevStateInt);
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
            else if (prevStateInt < 60)
            {
                [iv setImage:[UIImage imageNamed:@"empty"]];
                move = YES;
                
                //iv.hidden = YES;
                //[toUpdate addObject:[NSNumber numberWithInt:i]];
                
            }

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
    
    // added this
    
    
    /* // was for testing\
    if ((int)[toUpdate count] > 1)
    {
        NSLog(@"REMOVING MORE THAN ONE HILLARY AT ONCE!!!!!");
    }
     */
    
    //if ((int)[toUpdate count] > 0)
    if ((int)[toUpdate count] == 1)
    {
        NSLog(@"removing %lu number of hillaries!", (unsigned long)[toUpdate count]);
        for (NSNumber *n in toUpdate)
        {
            NSLog(@"removing hillary number: %@", n);
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
        //[trump setImage:[UIImage imageNamed:@"trump11.png"]];
        [trump setImage:[UIImage imageNamed:@"trumpNew2-neutral.png"]];
    }
    else
    {
        //[trump setImage:[UIImage imageNamed:@"trump10.png"]];
        [trump setImage:[UIImage imageNamed:@"trumpNew2-talking.png"]];
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
    
   // NSLog(@"after update: %@", [hillaries description]);
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (isPaused)
    {
        return;
    }
    
    [self makeHillaryBigger];
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if (motion == UIEventSubtypeMotionShake)
    {
        //AudioServicesPlaySystemSound(china1);
        [china play];
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (isPaused)
    {
        return;
    }
    
    UITouch *myTouch = [[event allTouches] anyObject];
    
    NSString *imageName;
    int randNum = arc4random_uniform(10);
    //imageName = @"emptyDrop2.png";
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
    //[tempHillary setFrame:CGRectMake(0, 0, 50, 65)];
    [tempHillary setFrame:CGRectMake(0, 0, 80, 100)];
    //[tempHillary setCenter:CGPointMake([myTouch locationInView:self.view].x, 60)]; // from when there was a status bar
    [tempHillary setCenter:CGPointMake([myTouch locationInView:self.view].x, 40)];
    [tempHillary setContentMode:UIViewContentModeScaleAspectFit];
    [self.view addSubview:tempHillary];
    [self.view bringSubviewToFront:tempHillary];
    
    [hillaries addObject:tempHillary];
    [hillaryStates addObject:[NSNumber numberWithInt:0]]; // 0 = hillary, 1 = collision/fire, >5 = hidden
    [self.view bringSubviewToFront:cloud];
    [self.view bringSubviewToFront:leaderboardButton];
    
    count++;
    [countLabel setText:[self addCommas:[NSString stringWithFormat:@"%i", count]]];
    numDropsNotInTotal++;
    [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%i", numDropsNotInTotal] forKey:@"extraDrops"];
    
    //[self updateTotalDropsByOne];
    //[self updateUserInfo];
    
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
        hillaryScale += .2;
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

- (NSString *)addCommas:(NSString *)oldString
{
    return [NSNumberFormatter localizedStringFromNumber:@([oldString intValue])
                                                         numberStyle:NSNumberFormatterDecimalStyle];
}

- (void)loadLeaderboard
{
    if (![self foundNetworkConnetion]) // no wifi
    {
        [self noWifiAlertView];
        [leaderboardButton setBackgroundImage:[UIImage imageNamed:@"trophy1.png"] forState:UIControlStateNormal];
        return; // no leaderboard if no wifi
    }
    
    isPaused = YES;
    
    //count = 1314;
    //count = 6400; // TODO DELETE THIS, only for testing!!!
    if ([self shouldUpdateLeaderboard])
    {
        if ([self isUserAlreadyOnLb])
        {
            NSLog(@"user is already on LB, updating position");
            [self updateUsersPositionOnLb];
        }
        else
        {
            NSLog(@"user is NOT already on LB, putting them on it now");
            [self updateLbWithThisUser];
        }
    }
    
    [self getLeaderboardFromFB];
    [self setLeaderboardValues]; // TODO this still isn't the most updated version of the leaderboard?
    
    
    
    leaderboard = [[UIView alloc] initWithFrame:CGRectMake(sw*.05, sh*.05, sw*.9, sh - 90)];
    [leaderboard setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:102./255 alpha:.65]];
    leaderboard.layer.cornerRadius = 15;
    leaderboard.layer.borderWidth = 5;
    leaderboard.layer.borderColor = [UIColor colorWithRed:0 green:0 blue:102./255 alpha:.8].CGColor;
    
    leaderboardTitle = [[UILabel alloc] initWithFrame:CGRectMake(5, 10, sw*.8, 40)];
    [leaderboardTitle setText:@"Leaderboard"];
    [leaderboardTitle setTextColor:[UIColor whiteColor]];
    [leaderboardTitle setFont:[UIFont fontWithName:@"Verdana" size:30]];
    [leaderboardTitle setTextAlignment:NSTextAlignmentCenter];
    [leaderboard addSubview:leaderboardTitle];
    
    [self setLeaderboardValues];
    /*
    // TODO make this real
    leaders = [[NSMutableArray alloc] initWithObjects:@"Jimmy Pennoyer", @"Madelynnn", @"Johnny Rocha", @"John CENA!!!", @"Ryan Busk", @"JustinMcManus", @"Apple Tester", @"Dan Stowe", nil];
    leaderScores = [[NSMutableArray alloc] initWithObjects:@"770,000", @"90,912", @"90,873", @"36,123", @"3,020", @"820", @"120", @"89", nil];
    */
     
    for (int i = 0; i < [leaders count]; i++)
    {
        UILabel *tempLeader = [[UILabel alloc] initWithFrame:CGRectMake(15, 50+(30*i), sw*.8, 30)];
        [tempLeader setTextColor:[UIColor whiteColor]];
        NSString *labelString = [NSString stringWithFormat:@"%i%@%@", i+1, @". ", [leaders objectAtIndex:i]];
        [tempLeader setText:labelString];
        [tempLeader setFont:[UIFont fontWithName:@"Verdana" size:18]];
        [tempLeader setTextAlignment:NSTextAlignmentLeft];
        
        UILabel *tempScore = [[UILabel alloc] initWithFrame:CGRectMake(15, 50+(30*i), sw*.8, 30)];
        [tempScore setTextColor:[UIColor whiteColor]];
        NSString *scoreString = [leaderScores objectAtIndex:i];
        [tempScore setText:scoreString];
        [tempScore setFont:[UIFont fontWithName:@"Verdana" size:18]];
        [tempScore setTextAlignment:NSTextAlignmentRight];
        
        [leaderboard addSubview:tempLeader];
        [leaderboard addSubview:tempScore];
    }
    
    leaderboardTotal = [[UILabel alloc] initWithFrame:CGRectMake(15, 50+(30*[leaders count]), sw*.8, 35)];
    [leaderboardTotal setTextColor:[UIColor whiteColor]];
    [leaderboardTotal setFont:[UIFont fontWithName:@"Verdana-Bold" size:20]];
    [leaderboardTotal setTextAlignment:NSTextAlignmentCenter];
    [leaderboardTotal setText:[NSString stringWithFormat:@"%@%@",@"Total Hits: ", [self addCommas:prevTotalDrops]]];
    [leaderboard addSubview:leaderboardTotal];
    
    leaderboardShareLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, sh - 90 - 55, sw*.8, 35)];
    [leaderboardShareLabel setTextColor:[UIColor whiteColor]];
    [leaderboardShareLabel setFont:[UIFont fontWithName:@"Verdana-Italic" size:18]];
    [leaderboardShareLabel setTextAlignment:NSTextAlignmentLeft];
    [leaderboardShareLabel setText:@"Share for better drops!"];
    [leaderboard addSubview:leaderboardShareLabel];
    
    fb = [[UIButton alloc] initWithFrame:CGRectMake(sw*.75 - 10, sh - 90 - 55, 35, 35)];
    [fb addTarget:self action:@selector(pressedFB:) forControlEvents:UIControlEventTouchUpInside];
    [fb setBackgroundImage:[UIImage imageNamed:@"facebookIcon.png"] forState:UIControlStateNormal];
    [leaderboard addSubview:fb];
    
    [self.view addSubview:leaderboard];
    [self.view bringSubviewToFront:leaderboard];
    [self.view bringSubviewToFront:leaderboardButton];
    
}

- (void)closeLeaderboard
{
    [leaderboard removeFromSuperview];
}

- (void)loadTrophyButton
{
    leaderboardButton = [[UIButton alloc] initWithFrame:CGRectMake(sw-60, 35, 35, 35)];
    [leaderboardButton setBackgroundImage:[UIImage imageNamed:@"trophy1.png"] forState:UIControlStateNormal];
    [leaderboardButton addTarget:self
               action:@selector(pressedLeaderboard:)
     forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:leaderboardButton];
}

- (IBAction)pressedLeaderboard:(id)sender
{
    [self updateTotalDropsWithExtraDrops];
    numDropsNotInTotal = 0;
    [self updateUserInfo];
    
    if (isPaused)
    {
        [leaderboardButton setBackgroundImage:[UIImage imageNamed:@"trophy1.png"] forState:UIControlStateNormal];
        [self closeLeaderboard];
        isPaused = NO;
        return;
    }
    
    [leaderboardButton setBackgroundImage:[UIImage imageNamed:@"closeButton.png"] forState:UIControlStateNormal];
    [self loadLeaderboard];
}

- (IBAction)pressedFB:(id)sender
{
    NSLog(@"Pressed facebook");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self.view setBackgroundColor:[UIColor blackColor]];
    sw = [[UIScreen mainScreen] bounds].size.width;
    sh = [[UIScreen mainScreen] bounds].size.height;
    
    [self loadTrophyButton];
   
    NSString *path = [NSString stringWithFormat:@"%@/china.wav", [[NSBundle mainBundle] resourcePath]];
    NSURL *soundUrl = [NSURL fileURLWithPath:path];
    china = [[AVAudioPlayer alloc] initWithContentsOfURL:soundUrl error:nil];
    NSString *path1 = [NSString stringWithFormat:@"%@/china_.wav", [[NSBundle mainBundle] resourcePath]];
    NSURL *soundUrl1 = [NSURL fileURLWithPath:path1];
    china_ = [[AVAudioPlayer alloc] initWithContentsOfURL:soundUrl1 error:nil];
    NSString *path2 = [NSString stringWithFormat:@"%@/china4.wav", [[NSBundle mainBundle] resourcePath]];
    NSURL *soundUrl2 = [NSURL fileURLWithPath:path2];
    china4 = [[AVAudioPlayer alloc] initWithContentsOfURL:soundUrl2 error:nil];
   
    
    NSString *path3 = [NSString stringWithFormat:@"%@/idc.wav", [[NSBundle mainBundle] resourcePath]];
    NSURL *soundUrl3 = [NSURL fileURLWithPath:path3];
    idc = [[AVAudioPlayer alloc] initWithContentsOfURL:soundUrl3 error:nil];
    NSString *path4 = [NSString stringWithFormat:@"%@/wall1.wav", [[NSBundle mainBundle] resourcePath]];
    NSURL *soundUrl4 = [NSURL fileURLWithPath:path4];
    wall1 = [[AVAudioPlayer alloc] initWithContentsOfURL:soundUrl4 error:nil];
    NSString *path5 = [NSString stringWithFormat:@"%@/highlyInappropriate.wav", [[NSBundle mainBundle] resourcePath]];
    NSURL *soundUrl5 = [NSURL fileURLWithPath:path5];
    highlyInapropriate = [[AVAudioPlayer alloc] initWithContentsOfURL:soundUrl5 error:nil];
    NSString *path6 = [NSString stringWithFormat:@"%@/waterSound.mp3", [[NSBundle mainBundle] resourcePath]];
    NSURL *soundUrl6 = [NSURL fileURLWithPath:path6];
    water = [[AVAudioPlayer alloc] initWithContentsOfURL:soundUrl6 error:nil];
    
    
    
    NSString *path7 = [NSString stringWithFormat:@"%@/cutGovtSpending.mp3", [[NSBundle mainBundle] resourcePath]];
    NSURL *soundUrl7 = [NSURL fileURLWithPath:path7];
    cutGovtSpending = [[AVAudioPlayer alloc] initWithContentsOfURL:soundUrl7 error:nil];
    NSString *path8 = [NSString stringWithFormat:@"%@/itsGoingToEnd.mp3", [[NSBundle mainBundle] resourcePath]];
    NSURL *soundUrl8 = [NSURL fileURLWithPath:path8];
    itsGoingToEnd = [[AVAudioPlayer alloc] initWithContentsOfURL:soundUrl8 error:nil];
    NSString *path9 = [NSString stringWithFormat:@"%@/imReallyRich.mp3", [[NSBundle mainBundle] resourcePath]];
    NSURL *soundUrl9 = [NSURL fileURLWithPath:path9];
    imReallyRich = [[AVAudioPlayer alloc] initWithContentsOfURL:soundUrl9 error:nil];
    NSString *path10 = [NSString stringWithFormat:@"%@/outOfControl.mp3", [[NSBundle mainBundle] resourcePath]];
    NSURL *soundUrl10 = [NSURL fileURLWithPath:path10];
    outOfControl = [[AVAudioPlayer alloc] initWithContentsOfURL:soundUrl10 error:nil];

    
    /*
    NSString *soundPath2 = [[NSBundle mainBundle] pathForResource:@"grunt2-2" ofType:@"wav"];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath: soundPath2], &(grunt2));
    NSString *soundPath3 = [[NSBundle mainBundle] pathForResource:@"smallSound1" ofType:@"wav"];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath: soundPath3], &(sound1));
    NSString *soundPath4 = [[NSBundle mainBundle] pathForResource:@"smallSound2" ofType:@"wav"];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath: soundPath4], &(sound2));
    NSString *soundPath5 = [[NSBundle mainBundle] pathForResource:@"smallSound3" ofType:@"wav"];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath: soundPath5], &(sound3));
    */
    
    
    trumpState = 0;
    hillaryScale = 1.;
    hillaries = [[NSMutableArray alloc] init];
    hillaryStates = [[NSMutableArray alloc] init];
    
    isPaused = NO;
    timer = [NSTimer scheduledTimerWithTimeInterval:.01 target:self selector:@selector(collision) userInfo:nil repeats:YES];
    //timer = [NSTimer scheduledTimerWithTimeInterval:.05 target:self selector:@selector(collision) userInfo:nil repeats:YES];

    
    
    // put uiimageviews in right spots
    
    CGSize screenSize      = [[UIScreen mainScreen] bounds].size;
    CGFloat widthOfScreen  = screenSize.width;
    CGFloat heightOfScreen = screenSize.height;
    
    cloud = [[UIImageView alloc] initWithFrame:CGRectMake(0, 12, widthOfScreen, 100)];
    // cloud = [[UIImageView alloc] initWithFrame:CGRectMake(0, 20, widthOfScreen, 100)]; // old one from when there was a status bar
    [cloud setImage:[UIImage imageNamed:@"cloud1.png"]];
    
    // countLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 40, widthOfScreen, 60)]; // old one from when there was a status bar
    countLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 32, widthOfScreen, 60)];
    [countLabel setFont:[UIFont fontWithName:@"Verdana" size:32]];
    [countLabel setTextColor:[UIColor whiteColor]];
    [countLabel setTextAlignment:NSTextAlignmentCenter];
    
    [self.view addSubview:cloud];
    [self.view addSubview:countLabel];
    [self.view bringSubviewToFront:countLabel];
    [self.view bringSubviewToFront:leaderboardButton];
    
    float trumpRatio = 270./375.; // height/width
    
    //trump = [[UIImageView alloc] initWithFrame:CGRectMake(0, heightOfScreen-50-trumpRatio*widthOfScreen, widthOfScreen, trumpRatio*widthOfScreen)];
    trump = [[UIImageView alloc] initWithFrame:CGRectMake(0, heightOfScreen-trumpRatio*widthOfScreen, widthOfScreen, trumpRatio*widthOfScreen)];
    [self.view addSubview:trump];
    
    
    // make trump outline uiviews
    
    /*
    trumpOutline1 = [[UIView alloc] initWithFrame:CGRectMake(0, heightOfScreen-50-trumpRatio*widthOfScreen*.38, widthOfScreen*.5, trumpRatio*widthOfScreen*.38)]; // left shoulder
    trumpOutline3 = [[UIView alloc] initWithFrame:CGRectMake(widthOfScreen*.5, heightOfScreen-50-trumpRatio*widthOfScreen*.28, widthOfScreen*.5, trumpRatio*widthOfScreen*.28)]; // right shoulder
    trumpOutline2 = [[UIView alloc] initWithFrame:CGRectMake(widthOfScreen*.5 - 60, heightOfScreen-50-trumpRatio*widthOfScreen, 120, trumpRatio*widthOfScreen*.5)]; // head
    */
    
    trumpOutline1 = [[UIView alloc] initWithFrame:CGRectMake(0, heightOfScreen-trumpRatio*widthOfScreen*.38, widthOfScreen*.5, trumpRatio*widthOfScreen*.38)]; // left shoulder
    trumpOutline3 = [[UIView alloc] initWithFrame:CGRectMake(widthOfScreen*.5, heightOfScreen-trumpRatio*widthOfScreen*.28, widthOfScreen*.5, trumpRatio*widthOfScreen*.28)]; // right shoulder
    trumpOutline2 = [[UIView alloc] initWithFrame:CGRectMake(widthOfScreen*.5 - 60, heightOfScreen-trumpRatio*widthOfScreen, 120, trumpRatio*widthOfScreen*.5)]; // head
     
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
    
    
    foundPrevTotalDrops = NO;
    
    // give this new user a uuid for firebase
    myRootRef = [[Firebase alloc] initWithUrl:@"https://rain-on-trump.firebaseio.com"];
    usersRef = [myRootRef childByAppendingPath: @"users"];
    lbRef = [myRootRef childByAppendingPath: @"leaders"];
    //totalsRef = [myRootRef childByAppendingPath: @"totals"];
    
    [self getPrevTotalDrops];
    [self getPrevTotalUsers];
    
    if (![[NSUserDefaults standardUserDefaults] stringForKey:@"uuid"]) // is first time in system, make them a new uuid and store it in defaults
    {
        numDropsNotInTotal = 0;
        uuid = [[NSUUID UUID] UUIDString];
        [[NSUserDefaults standardUserDefaults] setObject:uuid forKey:@"uuid"];
        [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%i", numDropsNotInTotal] forKey:@"extraDrops"];
        //[self updateTotalDropsWithScore]; // THIS MIGHT BE AN ISSUE BUT I THINK I FIXED IT
        [self updateTotalNumUsers];
        [self addAlertView];
    }
    else // is already in system, just get this user's uuid from defaults
    {
        uuid = [[NSUserDefaults standardUserDefaults] stringForKey:@"uuid"];
        username = [[NSUserDefaults standardUserDefaults] stringForKey:@"username"];
        numDropsNotInTotal = [[[NSUserDefaults standardUserDefaults] stringForKey:@"extraDrops"] intValue];
    }
    NSLog(@"my uuid: %@", uuid);
    
    usersRef = [usersRef childByAppendingPath: uuid];
    //prevTotalDrops = [[NSString alloc] init];
    
    
    // DO NOT DELETE THE LINES BELOW!!!!!!
    Firebase *totalsRef = [myRootRef childByAppendingPath: @"totals"];
    
    [totalsRef observeEventType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
        NSLog(@"got this data back:\n %@ -> %@", snapshot.key, snapshot.value);
        [self setPrevTotalDrops:snapshot.value[@"totalDrops"]];
    }];
    
    
    [self getLeaderboardFromFB];
    
    if ([self isUsernameNull])
    {
        username = @"Anonymous";
        [self addAlertView];
    }
}

- (bool)isUsernameNull
{
    if ([username length] == 0)
    {
        return true;
    }
    else
    {
        return false;
    }
}

/////////// FIREBASE STUFF ////////////////////////



- (void)updateUserInfo
{
    Firebase *thisUserRef2 = [usersRef childByAppendingPath: uuid];
    
    NSLog(@"updating user info");
    [thisUserRef2 observeEventType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
        NSLog(@"%@ -> %@", snapshot.key, snapshot.value);
    }];
    
    if (!username) // this happens for old users (before this update with Firebase) who exist but don't have a username yet
    {
        NSLog(@"calling add alert view for username for an old user");
        [self addAlertView];
        return; // will update user info later anyway
    }
    
    NSDictionary *thisUser = @{
                               @"displayName" : username,
                               @"score": [NSString stringWithFormat:@"%i", count],
                               @"level": @"-1",
                               @"isTopTen": @"no",
                               @"numFbShares": @"0",
                               @"numTwShares": @"0"};
    [usersRef setValue:thisUser];
}

- (void)updateTotalNumUsers
{
    NSLog(@"upating total num users");
    [self getPrevTotalUsers];

    Firebase *totalsRef = [myRootRef childByAppendingPath: @"totals"];
    Firebase *totalUsersRef = [totalsRef childByAppendingPath: @"totalUsers"];
    NSString *newTotal = [NSString stringWithFormat:@"%i", [prevTotalUsers intValue] + 1];
    // add one to total num of users
    [totalUsersRef setValue: newTotal];
}

- (void)getPrevTotalUsers
{
    Firebase *totalsRef = [myRootRef childByAppendingPath: @"totals"];
    
    [totalsRef observeEventType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
        NSLog(@"got this data back:\n %@ -> %@", snapshot.key, snapshot.value);
        [self setPrevTotalUsers:snapshot.value[@"totalUsers"]];
    }];
    
}

- (void)setPrevTotalUsers:(NSString *)prevTotalUsersFromDB
{
    NSLog(@"received prevTotalUsers = %@", prevTotalUsersFromDB);
    prevTotalUsers = prevTotalUsersFromDB;
}


- (void)getPrevTotalDrops
{
    Firebase *totalsRef = [myRootRef childByAppendingPath: @"totals"];
    
    [totalsRef observeEventType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
        NSLog(@"got this data back:\n %@ -> %@", snapshot.key, snapshot.value);
        [self setPrevTotalDrops:snapshot.value[@"totalDrops"]];
    }];

}

- (void)setPrevTotalDrops:(NSString *)prevTotalDropsFromDB
{
    if (prevTotalDropsFromDB)
    {
        foundPrevTotalDrops = YES;
        NSLog(@"received prevTotalDrops = %@", prevTotalDropsFromDB);
        prevTotalDrops = prevTotalDropsFromDB;
    }
    else
    {
        foundPrevTotalDrops = NO;
    }
}

/*
- (void)updateTotalDropsByOne
{
    NSLog(@"updating total drops by one");
    [self getPrevTotalDrops];
    [self getPrevTotalDrops];
   
    Firebase *totalsRef = [myRootRef childByAppendingPath: @"totals"];
    Firebase *totalDropsRef = [totalsRef childByAppendingPath: @"totalDrops"];
    
    // add 1 to total drops
    NSString *newTotal = [NSString stringWithFormat:@"%i", [prevTotalDrops intValue] + 1];
    [totalDropsRef setValue: newTotal];
    
    NSLog(@"total drops: %@ + 1 = %@", prevTotalDrops, newTotal);
   
}
 */

- (void)updateTotalDropsWithExtraDrops // drops that haven't been counted in the total yet, alternate to method above that has to be called every single freakin drop
{
    NSLog(@"updating total drops by extra");
    [self getPrevTotalDrops];
    if (!foundPrevTotalDrops)
    {
        [self getPrevTotalDrops];
    }
    
    if (foundPrevTotalDrops)
    {
    
        Firebase *totalsRef = [myRootRef childByAppendingPath: @"totals"];
        Firebase *totalDropsRef = [totalsRef childByAppendingPath: @"totalDrops"];
    
        // add 1 to total drops
        NSString *newTotal = [NSString stringWithFormat:@"%i", [prevTotalDrops intValue] + numDropsNotInTotal];
        [totalDropsRef setValue: newTotal];
    
        NSLog(@"total drops: %@ + (drops not in total yet)%i = %@", prevTotalDrops, numDropsNotInTotal, newTotal);
        foundPrevTotalDrops = NO;
        numDropsNotInTotal = 0;
        [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%i", numDropsNotInTotal] forKey:@"extraDrops"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    else
    {
        NSLog(@"didn't find prev total drops yet");
    }
    
}


- (void)updateTotalDropsWithScore
{
    NSLog(@"dating total drops with current score stored in defaults");
    NSLog(@"updating total drops by extra");
    [self getPrevTotalDrops];
    if (!foundPrevTotalDrops)
    {
        [self getPrevTotalDrops];
    }
    
    if (foundPrevTotalDrops)
    {

        Firebase *totalsRef = [myRootRef childByAppendingPath: @"totals"];
        Firebase *totalDropsRef = [totalsRef childByAppendingPath: @"totalDrops"];
    
        // add high score to total drops
        NSString *newTotal = [NSString stringWithFormat:@"%i", [prevTotalDrops intValue] + count];
        //NSDictionary *tempTotals = @{
        //                             @"totalDrops": newTotal
        //                             };
        //[totalsRef setValue: tempTotals];
        [totalDropsRef setValue: newTotal];
    
        NSLog(@"total drops: %@ + (score)%i = %@", prevTotalDrops, count, newTotal);
        
        }
        else
        {
            NSLog(@"didn't find prev total drops yet so couldn't use old score in grand total:(");
        }
}


// leaderboard

- (bool)shouldUpdateLeaderboard
{
    if (count > lowestScoreInLb)
    {
        // gotta make sure leaderboard hasn't changed since then
        [self getLeaderboardFromFB];
        [self setLeaderboardValues];
        
        if (count > lowestScoreInLb)
        {
            NSLog(@"should update leaderboard with this user's info");
            return true;
        }
    }
    NSLog(@"should NOT update leaderboard with this user's info");
    return false;
}

- (void)updateLbWithThisUser
{
    NSLog(@"currentLB: %@", [currentLb description]);
    NSMutableDictionary *newLb = [[NSMutableDictionary alloc] initWithDictionary:currentLb];
    NSLog(@"got here 0");
    
    if ([self isUsernameNull])
    {
        username = @"Anonymous";
        [self addAlertView];
    }
    
    NSLog(@"username: %@, uuid: %@, count:%i", username, uuid, count);
    NSDictionary *thisUserInfo = @{
                                   @"username":username,
                                   @"uuid":uuid,
                                   @"score":[NSString stringWithFormat:@"%i",count]
                                   };
    
     NSLog(@"got here 1");
     NSArray *words = [[NSArray alloc] initWithObjects:@"one", @"two", @"three", @"four", @"five", @"six", @"seven", @"eight", nil];
    
    int i = 1; // new rank of this user
    id importantKey;
    for (NSString *key in words) // start at top of leaderboard and go down, comparing scores
    {
         NSLog(@"got here 2");
        if (count > [[currentLb valueForKeyPath:[NSString stringWithFormat:@"%@.score", (id)key]] intValue])
        {
            importantKey = key;
            break;
        }
        i++;
    }
     NSLog(@"got here 3");
    
    NSLog(@"should put this user in spot %i", i);
    
    // THIS CHUNK WORKS YAY!
    int j = 1;
    NSMutableDictionary *prevDict;
    for (id key in currentLb)
    {
        if (key == importantKey) //if (j == i) // found the replacement spot for this user
        {
            NSLog(@"changing spot now");
            [newLb setObject:thisUserInfo forKey:key];
        }
        else if ([self isKeyGreaterThan:key withSecondKey:importantKey]) //(j > (i+1)) // objects below the list from this user must be lowered one rank
        {
            NSLog(@"moving lower one down");
            prevDict = [@{
                          @"score":[currentLb valueForKeyPath:[NSString stringWithFormat:@"%@.score", [self prevKey:key]]],
                          @"uuid":[currentLb valueForKeyPath:[NSString stringWithFormat:@"%@.uuid", [self prevKey:key]]],
                          @"username":[currentLb valueForKeyPath:[NSString stringWithFormat:@"%@.username", [self prevKey:key]]]
                          } mutableCopy];
            
            [newLb setObject:prevDict forKey:key];
        }
        else
        {
            NSLog(@"not yet");
        }
    
        j++;
    }
    
    
    NSLog(@"newLb right before sending %@", [newLb description]);
        // TODO this part doesn't
    [lbRef updateChildValues:newLb];
    
    
    /*
    if (i == 1) // error checking
    {
        NSLog(@"ERROR! in updateLbWithThisUser, thought we should update lb with this user but turns out their score wasn't high enough");
        return;
    }
*/

}

- (bool)isKeyGreaterThan:(id)first withSecondKey:(id)second
{
    NSArray *words = [[NSArray alloc] initWithObjects:@"one", @"two", @"three", @"four", @"five", @"six", @"seven", @"eight", nil];
    
    if ([words indexOfObject:first] > [words indexOfObject:second])
    {
        return true;
    }
    else
    {
        return false;
    }
    
}

- (NSString *)prevKey:(NSString *)key
{
    if ([key isEqualToString:@"one"])
    {
        NSLog(@"ERROR IN PREVKEY method!!!");
        return @"";
    }
    else if ([key isEqualToString:@"two"])
    {
        return @"one";
    }
    else if ([key isEqualToString:@"three"])
    {
        return @"two";
    }
    else if ([key isEqualToString:@"four"])
    {
        return @"three";
    }
    else if ([key isEqualToString:@"five"])
    {
        return @"four";
    }
    else if ([key isEqualToString:@"six"])
    {
        return @"five";
    }
    else if ([key isEqualToString:@"seven"])
    {
        return @"six";
    }
    else if ([key isEqualToString:@"eight"])
    {
        return @"seven";
    }
    return @"eight"; // issue
}

- (void)updateUsersPositionOnLb // TODO this method just doesn't work
{
    // find user's old spot in the leaderboard
    id usersPrevKey;
    for (id k in currentLb)
    {
        if ([[currentLb valueForKeyPath:[NSString stringWithFormat:@"%@.uuid", k]] intValue])
        {
            usersPrevKey = k;
        }
    }
    
    
    NSMutableDictionary *newLb = [[NSMutableDictionary alloc] initWithDictionary:currentLb];
    
    NSDictionary *thisUserInfo = @{
                                   @"username":username,
                                   @"uuid":uuid,
                                   @"score":[NSString stringWithFormat:@"%i",count]
                                   };
    
    NSArray *words = [[NSArray alloc] initWithObjects:@"one", @"two", @"three", @"four", @"five", @"six", @"seven", @"eight", nil];
    
    int i = 1; // new rank of this user
    id newKey;
    for (NSString *key in words) // start at top of leaderboard and go down, comparing scores
    {
        if (count > [[currentLb valueForKeyPath:[NSString stringWithFormat:@"%@.score", (id)key]] intValue])
        {
            newKey = key;
            break;
        }
        i++;
    }
    
    NSLog(@"should put this user in spot %i", i);
    
    
    
    // say the 5th place user should now be the 3rd place user. The above part finds the new and old spots (5 and 3). Below loops through the dict and finds the other users in that range 3rd-5th, aka 3rd user and 4th user, and moves them each down one spot. Then replace the 3rd place spot with the current user.
    NSMutableDictionary *prevDict;
    for (id key in currentLb) // TODO this doesn't work
    {
        if ([self isKeyBetweenTheseKeys:key withLower:usersPrevKey withUpper:newKey])
        {
                NSLog(@"moving lower one down");
                prevDict = [@{
                          @"score":[currentLb valueForKeyPath:[NSString stringWithFormat:@"%@.score", [self prevKey:key]]],
                          @"uuid":[currentLb valueForKeyPath:[NSString stringWithFormat:@"%@.uuid", [self prevKey:key]]],
                          @"username":[currentLb valueForKeyPath:[NSString stringWithFormat:@"%@.username", [self prevKey:key]]]
                          } mutableCopy];
            
                [newLb setObject:prevDict forKey:key];
        }
        else
        {
            NSLog(@"not yet");
        }
        
    }
    
    [newLb setObject:thisUserInfo forKey:newKey]; // put the current user in correct spot
    
    
    NSLog(@"newLb right before sending %@", [newLb description]);
    // TODO this part doesn't
    [lbRef updateChildValues:newLb];
    
    
    /*
     if (i == 1) // error checking
     {
     NSLog(@"ERROR! in updateLbWithThisUser, thought we should update lb with this user but turns out their score wasn't high enough");
     return;
     }
     */
    
}

- (bool)isKeyBetweenTheseKeys:(id)key withLower:(id)low withUpper:(id)high // half-inclusive, 3-5 range is high:3, low:5
{
    NSArray *words = [[NSArray alloc] initWithObjects:@"one", @"two", @"three", @"four", @"five", @"six", @"seven", @"eight", nil];
    if (([words indexOfObject:key] < [words indexOfObject:low]) && ([words indexOfObject:key] >= [words indexOfObject:high]))
    {
        return true;
    }
    else
    {
        return false;
    }
}

- (bool)isUserAlreadyOnLb
{
    if ([oneDict count] == 0)
    {
        NSLog(@"ERROR! oneDict is null, hasn't been set yet, so couldn't check if this user is already on lb or not");
        return false;
    }
    
    NSArray *uuids = [[NSArray alloc] initWithObjects:
               [oneDict objectForKey:@"uuid"],
               [twoDict objectForKey:@"uuid"],
               [threeDict objectForKey:@"uuid"],
               [fourDict objectForKey:@"uuid"],
               [fiveDict objectForKey:@"uuid"],
               [sixDict objectForKey:@"uuid"],
               [sevenDict objectForKey:@"uuid"],
               [eightDict objectForKey:@"uuid"],
               nil];

    
    if ([uuids containsObject:uuid])
    {
        return true;
    }
    else
    {
        return false;
    }
}



- (void)setLeaderboardValues
{
    // TODO add check to see if oneDict is null
    NSLog(@"one = %@", [oneDict description]);
    currentLb = [@{
                  @"one":oneDict,
                  @"two":twoDict,
                  @"three":threeDict,
                  @"four":fourDict,
                  @"five":fiveDict,
                  @"six":sixDict,
                  @"seven":sevenDict,
                  @"eight":eightDict
                  } mutableCopy];
    
    leaders = [[NSMutableArray alloc] initWithObjects:
    [oneDict objectForKey:@"username"],
    [twoDict objectForKey:@"username"],
    [threeDict objectForKey:@"username"],
    [fourDict objectForKey:@"username"],
    [fiveDict objectForKey:@"username"],
    [sixDict objectForKey:@"username"],
    [sevenDict objectForKey:@"username"],
    [eightDict objectForKey:@"username"],
    nil];
    
    leaderScores = [[NSMutableArray alloc] initWithObjects:
               [oneDict objectForKey:@"score"],
               [twoDict objectForKey:@"score"],
               [threeDict objectForKey:@"score"],
               [fourDict objectForKey:@"score"],
               [fiveDict objectForKey:@"score"],
               [sixDict objectForKey:@"score"],
               [sevenDict objectForKey:@"score"],
               [eightDict objectForKey:@"score"],
               nil];
    
    NSLog(@"leaders = %@", [leaders description]);
    NSLog(@"leaderScores = %@", [leaderScores description]);
    NSLog(@"current lb = %@", [currentLb description]);
}

- (void)setLowestScore:(int)lowestScore
{
    lowestScoreInLb = lowestScore;
    NSLog(@"set lowest score to %i", lowestScoreInLb);
}

- (void)setOneDict:(NSDictionary *)lb
{
    oneDict = [lb mutableCopy];
    
    for (id key in oneDict)
    {
        NSLog(@"key=%@, value=%@", key, [oneDict valueForKey:key]);
    }
}
- (void)setTwoDict:(NSDictionary *)lb
{
    twoDict = [lb mutableCopy];
    
    for (id key in twoDict)
    {
        NSLog(@"key=%@, value=%@", key, [twoDict valueForKey:key]);
    }
}
- (void)setThreeDict:(NSDictionary *)lb
{
    threeDict = [lb mutableCopy];
    
    for (id key in threeDict)
    {
        NSLog(@"key=%@, value=%@", key, [threeDict valueForKey:key]);
    }
}
- (void)setFourDict:(NSDictionary *)lb
{
    fourDict = [lb mutableCopy];
    
    for (id key in fourDict)
    {
        NSLog(@"key=%@, value=%@", key, [fourDict valueForKey:key]);
    }
}
- (void)setFiveDict:(NSDictionary *)lb
{
    fiveDict = [lb mutableCopy];
    
    for (id key in fiveDict)
    {
        NSLog(@"key=%@, value=%@", key, [fiveDict valueForKey:key]);
    }
}
- (void)setSixDict:(NSDictionary *)lb
{
    sixDict = [lb mutableCopy];
    
    for (id key in sixDict)
    {
        NSLog(@"key=%@, value=%@", key, [sixDict valueForKey:key]);
    }
}
- (void)setSevenDict:(NSDictionary *)lb
{
    sevenDict = [lb mutableCopy];
    
    for (id key in sevenDict)
    {
        NSLog(@"key=%@, value=%@", key, [sevenDict valueForKey:key]);
    }
}
- (void)setEightDict:(NSDictionary *)lb
{
    eightDict = [lb mutableCopy];
    
    for (id key in eightDict)
    {
        NSLog(@"key=%@, value=%@", key, [eightDict valueForKey:key]);
    }
}

- (void)getLeaderboardFromFB
{
 
    Firebase *eightRef = [lbRef childByAppendingPath:@"eight"];
    [eightRef observeEventType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
        NSLog(@"got this data back:\n %@ -> %@", snapshot.key, snapshot.value);
        // extra stuff because is lowest rank in leaderboard
        NSLog(@"score: %@", snapshot.value[@"score"]);
        [self setLowestScore:[snapshot.value[@"score"] intValue]];
        
        // update global 8th place dict
       [self setEightDict: @{
                      @"username":snapshot.value[@"username"],
                      @"uuid":snapshot.value[@"uuid"],
                      @"score":snapshot.value[@"score"]
                      }];
    }];
    
    Firebase *sevenRef = [lbRef childByAppendingPath:@"seven"];
    [sevenRef observeEventType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
        NSLog(@"got this data back:\n %@ -> %@", snapshot.key, snapshot.value);
        NSLog(@"score: %@", snapshot.value[@"score"]);
        
        [self setSevenDict: @{
                                 @"username":snapshot.value[@"username"],
                                 @"uuid":snapshot.value[@"uuid"],
                                 @"score":snapshot.value[@"score"]
                                 }];
    }];
    
    Firebase *sixRef = [lbRef childByAppendingPath:@"six"];
    [sixRef observeEventType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
        NSLog(@"got this data back:\n %@ -> %@", snapshot.key, snapshot.value);
        NSLog(@"score: %@", snapshot.value[@"score"]);
        
        [self setSixDict: @{
                              @"username":snapshot.value[@"username"],
                              @"uuid":snapshot.value[@"uuid"],
                              @"score":snapshot.value[@"score"]
                              }];

    }];
    
    
    Firebase *fiveRef = [lbRef childByAppendingPath:@"five"];
    [fiveRef observeEventType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
        NSLog(@"got this data back:\n %@ -> %@", snapshot.key, snapshot.value);
        NSLog(@"score: %@", snapshot.value[@"score"]);
        
        [self setFiveDict: @{
                              @"username":snapshot.value[@"username"],
                              @"uuid":snapshot.value[@"uuid"],
                              @"score":snapshot.value[@"score"]
                              }];
    }];
    
    Firebase *fourRef = [lbRef childByAppendingPath:@"four"];
    [fourRef observeEventType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
        NSLog(@"got this data back:\n %@ -> %@", snapshot.key, snapshot.value);
        NSLog(@"score: %@", snapshot.value[@"score"]);
        
        [self setFourDict: @{
                              @"username":snapshot.value[@"username"],
                              @"uuid":snapshot.value[@"uuid"],
                              @"score":snapshot.value[@"score"]
                              }];
    }];
    
    Firebase *threeRef = [lbRef childByAppendingPath:@"three"];
    [threeRef observeEventType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
        NSLog(@"got this data back:\n %@ -> %@", snapshot.key, snapshot.value);
        NSLog(@"score: %@", snapshot.value[@"score"]);
        
        [self setThreeDict: @{
                              @"username":snapshot.value[@"username"],
                              @"uuid":snapshot.value[@"uuid"],
                              @"score":snapshot.value[@"score"]
                              }];
    }];
    
    Firebase *twoRef = [lbRef childByAppendingPath:@"two"];
    [twoRef observeEventType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
        NSLog(@"got this data back:\n %@ -> %@", snapshot.key, snapshot.value);
        NSLog(@"score: %@", snapshot.value[@"score"]);
        
        [self setTwoDict: @{
                              @"username":snapshot.value[@"username"],
                              @"uuid":snapshot.value[@"uuid"],
                              @"score":snapshot.value[@"score"]
                              }];
    }];
    
    Firebase *oneRef = [lbRef childByAppendingPath:@"one"];
    [oneRef observeEventType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
        NSLog(@"got this data back:\n %@ -> %@", snapshot.key, snapshot.value);
        NSLog(@"score: %@", snapshot.value[@"score"]);
        
        [self setOneDict: @{
                              @"username":snapshot.value[@"username"],
                              @"uuid":snapshot.value[@"uuid"],
                              @"score":snapshot.value[@"score"]
                              }];
    }];
  

 /*
     // BELOW RESETS THE LEADERBOARD TO RANDOS
     Firebase *leadersRef = [myRootRef childByAppendingPath: @"leaders"];
    NSDictionary *oneDict = @{
                                  @"uuid": @"0000000",
                                  @"username":@"ALEXXX",
                                  @"score":@"11737"
                                  };
    NSDictionary *twoDict = @{
                              @"uuid": @"0000001",
                              @"username":@"jpennoyer",
                              @"score":@"8234"
                              };
    NSDictionary *threeDict = @{
                              @"uuid": @"0000002",
                              @"username":@"Schmed17",
                              @"score":@"5432"
                              };
    NSDictionary *fourDict = @{
                              @"uuid": @"0000003",
                              @"username":@"John Rocha",
                              @"score":@"4786"
                              };
    NSDictionary *fiveDict = @{
                              @"uuid": @"0000004",
                              @"username":@"Trumpinator",
                              @"score":@"4770"
                              };
    NSDictionary *sixDict = @{
                              @"uuid": @"0000005",
                              @"username":@"LeGinge",
                              @"score":@"3540"
                              };
    NSDictionary *sevenDict = @{
                              @"uuid": @"0000006",
                              @"username":@"JackK",
                              @"score":@"3211"
                              };
    NSDictionary *eightDict = @{
                              @"uuid": @"0000007",
                              @"username":@"Anonymous",
                              @"score":@"1260"
                              };
    
    
    NSDictionary *tempLeaders = @{
                                 @"one": oneDict,
                                 @"two": twoDict,
                                 @"three": threeDict,
                                 @"four": fourDict,
                                 @"five": fiveDict,
                                 @"six": sixDict,
                                 @"seven": sevenDict,
                                 @"eight": eightDict,
                                 };
    [leadersRef setValue: tempLeaders];
   */
}

//////////////////////////////////////////////////////////




- (void)viewDidAppear:(BOOL)animated
{
    // if close app, then update total drops too
    /*
    [self getPrevTotalDrops];
    [self getPrevTotalDrops];
    [self updateTotalDropsWithExtraDrops];
    [self updateUserInfo];
    numDropsNotInTotal = 0;
     */
    
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


//////////////// handle alert view stuff ///////////////////////////////////////////////

- (void)diffUsernameAlertView
{
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:
                              @"Oops..." message:@"That username is either taken or is too long. Pick a different one." delegate:self
                                             cancelButtonTitle:@"I'll just be anonymous" otherButtonTitles:@"Okay", nil];
    alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alertView show];
}

- (void)noWifiAlertView
{
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:
                              @"Oh no!" message:@"Your device couldn't connect to the internet. Make sure your wifi is turned on." delegate:self
                                             cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
    [alertView show];
}

-(void)addAlertView
{
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:
                              @"Hey there!" message:@"Please enter a username (e.g. Schmed1995):" delegate:self
                                             cancelButtonTitle:@"I refuse" otherButtonTitles:@"Okay", nil];
    alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alertView show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:
(NSInteger)buttonIndex{
    NSLog(@"%@", [alertView textFieldAtIndex:0].text);
    switch (buttonIndex) {
        case 0:
            NSLog(@"Cancel button clicked");
            username = @"Anonymous";
            break;
        case 1:
            NSLog(@"OK button clicked");
            if ([self checkUsernameValid:[alertView textFieldAtIndex:0].text] == 1)
            {
                username = [alertView textFieldAtIndex:0].text;
            }
            else
            {
                [self diffUsernameAlertView];
            }
            break;
            
        default:
            break;
    }
    [[NSUserDefaults standardUserDefaults] setObject:username forKey:@"username"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (int)checkUsernameValid:(NSString *)name
{ // right now only checks length... TODO: make it check for matching usernames
    NSUInteger length = [name length];
    if (length > 12 || length == 0)
    {
        return 0;
    }
    else
    {
        return 1;
    }
}

////////////////////////////////////// handle iAd stuff ///////////////////////////////////////////////////////////
/*
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
*/

- (BOOL)foundNetworkConnetion
{
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [reachability currentReachabilityStatus];
    return networkStatus != NotReachable;
}

-(BOOL)canBecomeFirstResponder {
    return YES;
}



@end
