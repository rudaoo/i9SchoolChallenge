//
//  ChallengeScreenViewController.m
//  i9School Challenges
//
//  Created by Rudney Camargo Pereira on 26/02/18.
//  Copyright © 2018 Rudney Camargo Pereira. All rights reserved.
//

#import "ChallengeScreenViewController.h"
#import "ChallengeMethodsTableViewCell.h"

@interface ChallengeScreenViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *circleHintView;
@property (weak, nonatomic) IBOutlet UIView *circleHintView2;
@property (weak, nonatomic) IBOutlet UIView *circleHintView3;

@property (weak, nonatomic) IBOutlet UILabel *buildButtonLabel;

@end

@implementation ChallengeScreenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self registerCellNibs];
    self.circleHintView.layer.borderColor = [[UIColor whiteColor] CGColor];
    self.circleHintView2.layer.borderColor = [[UIColor whiteColor] CGColor];
    self.circleHintView3.layer.borderColor = [[UIColor whiteColor] CGColor];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.tableView reloadData];
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



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 4;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ChallengeMethodsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ChallengeMethodsTableViewCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (indexPath.row == 0) {
        [cell.upperLittleArrow setHidden:YES];
    }
    else if(indexPath.row == 3) {
        [cell.bottonLittleArrow setHidden:YES];
    }
   
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return UITableViewAutomaticDimension;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 150;
}

-(void) registerCellNibs {
    
    [self.tableView registerNib:[UINib nibWithNibName:@"ChallengeMethodsTableViewCell" bundle:nil] forCellReuseIdentifier:@"ChallengeMethodsTableViewCell"];
    
}

- (IBAction)onBuildButtonPressed:(UIButton *)sender {
    
    if (!sender.selected) {
        
        [sender setSelected:YES];
        [self.buildButtonLabel setText:@"Parar"];
    }
    else {
        
        [sender setSelected:NO];
        [self.buildButtonLabel setText:@"Rodar"];
    }
}


@end
