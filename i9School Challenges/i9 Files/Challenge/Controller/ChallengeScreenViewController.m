//
//  ChallengeScreenViewController.m
//  i9School Challenges
//
//  Created by Rudney Camargo Pereira on 26/02/18.
//  Copyright © 2018 Rudney Camargo Pereira. All rights reserved.
//

#import "ChallengeScreenViewController.h"

@interface ChallengeScreenViewController ()

@end

@implementation ChallengeScreenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
