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

@property (weak, nonatomic) IBOutlet UIButton *moveFowardButton;
@property (weak, nonatomic) IBOutlet UIButton *moveBackButton;
@property (weak, nonatomic) IBOutlet UIButton *turnRightButton;
@property (weak, nonatomic) IBOutlet UIButton *turnLeftButton;

@property (strong, nonatomic) NSMutableArray *actionsSequence;


@end

@implementation ChallengeScreenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self registerCellNibs];
    self.actionsSequence = [[NSMutableArray alloc]init];
    
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
    
    return [self.actionsSequence count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ChallengeMethodsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ChallengeMethodsTableViewCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.methodNameLabel.text = [self.actionsSequence objectAtIndex:indexPath.row];
    [cell.upperLittleArrow setHidden:NO];
    [cell.bottonLittleArrow setHidden:NO];
    [cell.eraseButton addTarget:self action:@selector(eraseCarAction:) forControlEvents:UIControlEventTouchUpInside];

    
    if (indexPath.row == 0) {
        
        [cell.upperLittleArrow setHidden:YES];
    }
    else if(indexPath.row + 1 == ([self.actionsSequence count])) {
        
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

- (IBAction)onButtonCarActionPressed:(UIButton *)sender {
    
    if (sender == self.moveFowardButton) {
        
        [self.actionsSequence addObject:@"  MoverParaFrente( )  "];
    }
    else if (sender == self.moveBackButton) {
        
        [self.actionsSequence addObject:@"  MoverParaTras( )  "];

    }
    else if (sender == self.turnRightButton) {
        
        [self.actionsSequence addObject:@"  VirarParaDireita( )  "];

    }
    else if (sender == self.turnLeftButton) {
        
        [self.actionsSequence addObject:@"  VirarParaEsquerda( )  "];

    }
    
    NSIndexPath *newIndexPath = [NSIndexPath indexPathForRow:[self.actionsSequence count]-1 inSection:0];
    
    [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationRight];
    
    if ([self.actionsSequence count] > 2) {
        
         dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.3 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[self.actionsSequence count]-2 inSection:0];
            [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
         });
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.3 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{

        [self.tableView scrollToRowAtIndexPath:newIndexPath atScrollPosition:UITableViewScrollPositionBottom animated:TRUE];
    });
}

-(void) eraseCarAction:(UIButton*) sender {
    
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:self.tableView];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:buttonPosition];
    NSIndexPath *newindexPath = [NSIndexPath indexPathForRow:indexPath.row - 1 inSection:0];

    
    if (indexPath.row == ([self.actionsSequence count] - 1)) {
        
        [self.actionsSequence removeObjectAtIndex:indexPath.row];
        
        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationLeft];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.3 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            
            NSIndexPath *newindexPath = [NSIndexPath indexPathForRow:indexPath.row - 1 inSection:0];
            [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:newindexPath] withRowAnimation:UITableViewRowAnimationNone];
        });
        
        [self.tableView scrollToRowAtIndexPath:newindexPath atScrollPosition:UITableViewScrollPositionMiddle animated:TRUE];
    }
    else {

        [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionMiddle animated:TRUE];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.3 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{

            [self.actionsSequence removeObjectAtIndex:indexPath.row];
            [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationLeft];
        });
    }
    
}



@end
