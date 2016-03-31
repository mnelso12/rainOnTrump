//
//  ViewController.m
//  Rain on Trump
//
//  Created by MadelynNelson on 3/31/16.
//  Copyright (c) 2016 Madelyn Nelson. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)collision
{
    
    for (UIImageView *iv in hillaries)
    {
        // watch for collisions
        if (CGRectIntersectsRect(iv.frame, trump.frame))
        {
            iv.hidden = YES;
            NSLog(@"Collision");
        }
        
        // make them fall
        CGPoint oldCenter = iv.center;
        [iv setCenter:CGPointMake(oldCenter.x, oldCenter.y+3)];
    }
    
    
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
    
    UIImageView *tempHillary = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"hillary1.jpg"]];
    [tempHillary setFrame:CGRectMake(0, 0, 30, 30)];
    [tempHillary setCenter:CGPointMake([myTouch locationInView:self.view].x, 60)];
    [self.view addSubview:tempHillary];
    
    [hillaries addObject:tempHillary];
    [self.view bringSubviewToFront:cloud];
    

    
    //hillary.center = [myTouch locationInView:self.view];
    [self applyHillarySize];
}

- (void)makeHillaryBigger
{
    sizeTimer = [NSTimer scheduledTimerWithTimeInterval:.1 target:self selector:@selector(increaseHillarySize) userInfo:nil repeats:YES];
}

- (void)increaseHillarySize
{
    hillaryScale += 10.;
}

- (void)applyHillarySize
{
    UIImageView *iv = [hillaries objectAtIndex:[hillaries count]-1]; // got last hillary
    CGPoint oldCenter = iv.center;
    [iv setFrame:CGRectMake(oldCenter.x, oldCenter.y, hillaryScale+30, hillaryScale+30)];
    hillaryScale = 1.;
    [sizeTimer invalidate];

}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self.view setBackgroundColor:[UIColor blackColor]];
    
    hillaryScale = 1.;
    [self.view bringSubviewToFront:cloud];
    hillaries = [[NSMutableArray alloc] initWithObjects: nil];
    timer = [NSTimer scheduledTimerWithTimeInterval:.01 target:self selector:@selector(collision) userInfo:nil repeats:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
