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
@property (weak, nonatomic) IBOutlet UILabel *timerLabel;

@property (strong, nonatomic) NSMutableArray *actionsSequence;
@property (strong, nonatomic) NSTimer *stopWatchTimer;
@property (strong, nonatomic) NSDate *startDate;
@property (nonatomic) BOOL challengeRunning;


@end

@implementation ChallengeScreenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self registerCellNibs];
    self.actionsSequence = [[NSMutableArray alloc]init];
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]
                                               initWithTarget:self action:@selector(longPressGestureRecognized:)];
    [self.tableView addGestureRecognizer:longPress];

    
    self.circleHintView.layer.borderColor = [[UIColor whiteColor] CGColor];
    self.circleHintView2.layer.borderColor = [[UIColor whiteColor] CGColor];
    self.circleHintView3.layer.borderColor = [[UIColor whiteColor] CGColor];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.tableView reloadData];

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
        self.challengeRunning = YES;
        [self startTimer];
        [self finishChallenge];

    }
    else {
        
        [sender setSelected:NO];
        [self.buildButtonLabel setText:@"Rodar"];
        self.challengeRunning = NO;
        [self stopTimer];
    }
}

- (IBAction)onButtonCarActionPressed:(UIButton *)sender {
    
    if (!self.challengeRunning) {
        return;
    }
    
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
    
    if (!self.challengeRunning) {
        return;
    }
    
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
        
        if ([self.actionsSequence count] > 0) {
            
            [self.tableView scrollToRowAtIndexPath:newindexPath atScrollPosition:UITableViewScrollPositionMiddle animated:TRUE];
        }
        
    }
    else {

        [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionMiddle animated:TRUE];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.3 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{

            [self.actionsSequence removeObjectAtIndex:indexPath.row];
            [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationLeft];
        });
    }
    
}



- (IBAction)longPressGestureRecognized:(id)sender {
    
    if (!self.challengeRunning) {
        return;
    }
    
    
    UILongPressGestureRecognizer *longPress = (UILongPressGestureRecognizer *)sender;
    UIGestureRecognizerState state = longPress.state;
    
    CGPoint location = [longPress locationInView:self.tableView];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:location];
    
    static UIView       *snapshot = nil;        ///< A snapshot of the row user is moving.
    static NSIndexPath  *sourceIndexPath = nil; ///< Initial index path, where gesture begins.
    
    switch (state) {
        case UIGestureRecognizerStateBegan: {
            if (indexPath) {
                sourceIndexPath = indexPath;
                
                UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
                
                // Take a snapshot of the selected row using helper method.
                snapshot = [self customSnapshoFromView:cell];
                
                // Add the snapshot as subview, centered at cell's center...
                __block CGPoint center = cell.center;
                snapshot.center = center;
                snapshot.alpha = 0.0;
                [self.tableView addSubview:snapshot];
                [UIView animateWithDuration:0.25 animations:^{
                    
                    // Offset for gesture location.
                    center.y = location.y;
                    snapshot.center = center;
                    snapshot.transform = CGAffineTransformMakeScale(1.05, 1.05);
                    snapshot.alpha = 0.98;
                    cell.alpha = 0.0;
                    cell.hidden = YES;
                    
                }];
            }
            break;
        }
            
        case UIGestureRecognizerStateChanged: {
            CGPoint center = snapshot.center;
            center.y = location.y;
            snapshot.center = center;
            
            // Is destination valid and is it different from source?
            if (indexPath && ![indexPath isEqual:sourceIndexPath]) {
                
                // ... update data source.
                [self.actionsSequence exchangeObjectAtIndex:indexPath.row withObjectAtIndex:sourceIndexPath.row];
                
                // ... move the rows.
                [self.tableView moveRowAtIndexPath:sourceIndexPath toIndexPath:indexPath];
                
                // ... and update source so it is in sync with UI changes.
                sourceIndexPath = indexPath;
            }
            break;
        }
            
        default: {
            // Clean up.
            UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:sourceIndexPath];
            cell.alpha = 0.0;
            
            [UIView animateWithDuration:0.25 animations:^{
                
                snapshot.center = cell.center;
                snapshot.transform = CGAffineTransformIdentity;
                snapshot.alpha = 0.0;
                cell.alpha = 1.0;
                
            } completion:^(BOOL finished) {
                
                cell.hidden = NO;
                sourceIndexPath = nil;
                [snapshot removeFromSuperview];
                snapshot = nil;
                [self.tableView reloadData];
                
            }];
            
            break;
        }
    }
}


-(void) finishChallenge {
    
    NSLog(@"%@", self.actionsSequence);
    NSLog(@"%@", self.timerLabel.text);
}


- (void)updateTimer {
    // Create date from the elapsed time
    NSDate *currentDate = [NSDate date];
    NSTimeInterval timeInterval = [currentDate
                                   timeIntervalSinceDate:self.startDate];
    NSLog(@"time interval %f",timeInterval);
    
    NSDate *timerDate = [NSDate
                         dateWithTimeIntervalSince1970:timeInterval];
    
    // Create a date formatter
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"mm:ss"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0.0]];
    
    
    // Format the elapsed time and set it to the label
    NSString *timeString = [dateFormatter stringFromDate:timerDate];
    self.timerLabel.text = timeString;
}


#pragma mark - Helper methods

/** @brief Returns a customized snapshot of a given view. */
- (UIView *)customSnapshoFromView:(UIView *)inputView {
    
    // Make an image from the input view.
    UIGraphicsBeginImageContextWithOptions(inputView.bounds.size, NO, 0);
    [inputView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    // Create an image view.
    UIView *snapshot = [[UIImageView alloc] initWithImage:image];
    snapshot.layer.masksToBounds = NO;
    snapshot.layer.cornerRadius = 0.0;
    snapshot.layer.shadowOffset = CGSizeMake(-5.0, 0.0);
    snapshot.layer.shadowRadius = 5.0;
    snapshot.layer.shadowOpacity = 0.4;
    
    return snapshot;
}

- (void)stopTimer
{
    [self.stopWatchTimer invalidate];
    self.stopWatchTimer = nil;
    [self updateTimer];
    
}

- (void)startTimer
{
    
    if (self.stopWatchTimer) {
        [self.stopWatchTimer invalidate];
        self.stopWatchTimer = nil;
    }
    
    self.startDate = [NSDate date];
    
    // Create the stop watch timer that fires every 100 ms
    self.stopWatchTimer = [NSTimer scheduledTimerWithTimeInterval:1.0/10.0
                                                           target:self
                                                         selector:@selector(updateTimer)
                                                         userInfo:nil
                                                          repeats:YES];
}



@end
