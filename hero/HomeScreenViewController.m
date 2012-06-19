//
//  HomeScreenViewController.m
//  hero
//
//  Created by Minhao Zhang on 2012-06-19.
//  Copyright (c) 2012 Zentertain. All rights reserved.
//

#import "HomeScreenViewController.h"
#import "AppDelegate.h"

@interface HomeScreenViewController ()

@end

@implementation HomeScreenViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.wantsFullScreenLayout = YES;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}

- (void)onBFTapped:(id)sender
{
    CCDirector * director = [CCDirector sharedDirector];
    [HEROAPP.navController pushViewController:director
                                     animated:YES];
}
@end
