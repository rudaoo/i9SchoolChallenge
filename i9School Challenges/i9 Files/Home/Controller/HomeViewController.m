//
//  HomeViewController.m
//  i9School Challenges
//
//  Created by Rudney Camargo Pereira on 19/02/18.
//  Copyright © 2018 Rudney Camargo Pereira. All rights reserved.
//

#import "HomeViewController.h"
#import "ChallengeScreenViewController.h"

@interface HomeViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *logoImageView;
@property (weak, nonatomic) IBOutlet UIImageView *kidsImageView;

@property (nonatomic, strong) NSArray *kidsImageArray;
@property (nonatomic) int imagePosition;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.kidsImageArray = [NSArray arrayWithObjects:@"ipad2", @"ipad3", @"ipad4", @"ipad1",  nil];
    self.logoImageView.layer.masksToBounds = YES;
    self.kidsImageView.layer.masksToBounds = YES;
    self.imagePosition = 0;
    [self fadeOffKidsImage];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    
}


-(void) fadeOffKidsImage {
    
    [UIView animateWithDuration:2 delay:4 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
        [self.kidsImageView setAlpha:0.0f];
        
    } completion:^(BOOL finished) {
        [self changeImage];
        [self fadeInKidsImage];
    }];
}

-(void) fadeInKidsImage {
    
    [UIView animateWithDuration:2 delay:0 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
        [self.kidsImageView setAlpha:1.0f];
        
    } completion:^(BOOL finished) {
        
        [self fadeOffKidsImage];

    }];
}

-(void) changeImage {
    
    if (self.imagePosition > 3) {
        self.imagePosition = 0;
    }
    [self.kidsImageView setImage:[UIImage imageNamed:[self.kidsImageArray objectAtIndex:self.imagePosition]]];
    self.imagePosition++;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onButtonChallengeTapped:(id)sender {
    
    ChallengeScreenViewController *vc = [ChallengeScreenViewController initFromStoryboard:@"ChallengeScreen"];
    [self.navigationController pushViewController:vc animated:YES];
}


@end
