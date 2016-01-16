//
//  ViewController.m
//  Lesson 30 HW 2
//
//  Created by Alex on 14.01.16.
//  Copyright © 2016 Alex. All rights reserved.
//

#import "ViewController.h"
#import "APColor.h"
#import "APStudent.h"

@interface ViewController ()

@property (strong, nonatomic) NSMutableArray* arrayColors;
@property (strong, nonatomic) NSMutableArray* arrayStudents;
@property (strong, nonatomic) NSArray* arraySortedStudents;
@property (strong, nonatomic) NSMutableArray* arrayBestStudents;
@property (strong, nonatomic) NSMutableArray* array4ScoreStudents;
@property (strong, nonatomic) NSMutableArray* array3ScoreStudents;
@property (strong, nonatomic) NSMutableArray* array2ScoreStudents;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.arrayColors            = [[NSMutableArray alloc] init];
    self.arrayStudents          = [[NSMutableArray alloc] init];
    self.arrayBestStudents      = [[NSMutableArray alloc] init];
    self.array4ScoreStudents    = [[NSMutableArray alloc] init];
    self.array3ScoreStudents    = [[NSMutableArray alloc] init];
    self.array2ScoreStudents    = [[NSMutableArray alloc] init];
    
    // for student mode - lets make 1000 objects of classes color with properties - name and color ofc
    
    for (int i = 0; i<1000; i++) {
        
        UIColor* colorForRaw = [self randomColor];
        
        CGFloat red, green, blue, alpha ;
        
        [colorForRaw getRed:&red green:&green blue:&blue alpha:&alpha ];
        
        APColor* colorObj = [[APColor alloc] init];
        
        colorObj.color = colorForRaw;
        
        colorObj.name = [NSString stringWithFormat:@"COLOR IN RGB {%.2f, %.2f, %.2f}", red, green, blue];
        
        [self.arrayColors addObject:colorObj];
        

    }
    
    NSArray* arrayNames = [[NSArray alloc] initWithObjects:@"Stella", @"John", @"Kir", @"Ivan", @"Mila", nil];
    NSArray* arrayLastNames = [[NSArray alloc] initWithObjects:@"Davudoff", @"Egalt", @"Burunduk", @"Abricosoff", @"Celikoff", nil];
    
    for (int i = 0; i<30; i++) {
        
        APStudent* student = [[APStudent alloc] init];
        
        student.firstName = [arrayNames objectAtIndex:arc4random() % [arrayNames count]];
        
        student.lastName = [arrayLastNames objectAtIndex:arc4random() % [arrayLastNames count]];
        
        //student.averageScore = (CGFloat)(arc4random() % 301) /100.f+2;
        
        student.averageScore = arc4random_uniform(4) +2 ;
        
        [self.arrayStudents addObject:student];

    }
    
    self.arraySortedStudents = [[NSArray alloc] initWithArray:self.arrayStudents];
    
    self.arraySortedStudents = [self.arraySortedStudents  sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [[(APStudent*)obj1 lastName] compare:[(APStudent*)obj2 lastName]];
    }];
    
    // groups for superman. they r already sorted
    for (APStudent* student in self.arraySortedStudents) {
        
        
        if (student.averageScore == 2) {
            [self.array2ScoreStudents addObject:student];
            
        }
        
        if (student.averageScore == 3) {
            [self.array3ScoreStudents addObject:student];
        }
        
        if (student.averageScore == 4) {
            [self.array4ScoreStudents addObject:student];
        }
        
        if (student.averageScore == 5) {
            [self.arrayBestStudents addObject:student];
        }
    }
    
    //  a 20 insets - test in Alex's lesson
    /*
    UIEdgeInsets inset = UIEdgeInsetsMake(20, 0, 0, 0);
    
    self.tableView.contentInset = inset;
    
    self.tableView.scrollIndicatorInsets = inset;
    */
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

# pragma mark - UITableViewDataSource


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    NSLog(@"numberOfSectionsInTableView");
    
    return 4+1;
    
    // this is for Fonts From Lesson of Alex
    //return [[UIFont familyNames] count];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSLog(@"numberOfRowsInSection - %ld", section);
    
    NSInteger numberOfRowsInSection;
    
    switch (section) {
        case 0:
            numberOfRowsInSection = [self.arrayBestStudents count];
            break;
        case 1:
            numberOfRowsInSection = [self.array4ScoreStudents count];
            break;
        case 2:
            numberOfRowsInSection = [self.array3ScoreStudents count];
            break;
        case 3:
            numberOfRowsInSection = [self.array2ScoreStudents count];
            break;
        case 4:
            numberOfRowsInSection = 10;
            break;
            
        default:
            break;
    }
    
    return numberOfRowsInSection;
    
    // for master
    //return [self.arraySortedStudents count];
    
    //return 1000;
    
    /* this is for Fonts From Lesson of Alex
    NSArray* familyNames = [UIFont familyNames];
    
    NSString* familyName = [familyNames objectAtIndex:section];
    
    NSArray* fontNames = [UIFont fontNamesForFamilyName:familyName];
    
    return [fontNames count];
    */
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    NSString* nameSection;
    
    switch (section) {
        case 0:
            nameSection = @"BEST STUDENTS";
            break;
        case 1:
            nameSection = @"4 score STUDENTS";
            break;
        case 2:
            nameSection = @"3 score STUDENTS";
            break;
        case 3:
            nameSection = @"2 score STUDENTS";
            break;
        case 4:
            nameSection = @"AGAIN RGB";
            break;
            
        default:
            break;
    }
    
    return nameSection;
    
    /* this is for Fonts From Lesson of Alex
    NSArray* familyNames = [UIFont familyNames];
    
    NSString* familyName = [familyNames objectAtIndex:section];
    
    return familyName; // this will be in a header in section
     */
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"cellForRowAtIndexPath: { %ld, %ld }", indexPath.section, indexPath.row);
    
    
    static NSString* identifier = @"Cell";
    static NSString* identifierForMI = @"CellForMI";
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    UITableViewCell* cellForMI = [tableView dequeueReusableCellWithIdentifier:identifierForMI];
    
    
    if (indexPath.section == 4) { // THIS IS FOR MISHA IMPOSSIBLE
        if (!cellForMI) {
            cellForMI = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierForMI];
        }
        
        APColor* color = [self.arrayColors objectAtIndex:indexPath.row];
        cellForMI.textLabel.textColor = color.color ;
        cellForMI.textLabel.font = [UIFont fontWithName:@"Arial" size:12];
        cellForMI.textLabel.text = [NSString stringWithFormat:@"%@", color.name];
     
         return cellForMI;
    } else {
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
            
        }
        
        APColor* color = [self.arrayColors objectAtIndex:indexPath.row];
        cell.textLabel.textColor = color.color ;
        cell.textLabel.font = [UIFont fontWithName:@"Arial" size:12];
        
        switch (indexPath.section) {
            case 0:
                [self makeCells:indexPath.row :cell :self.arrayBestStudents];
                break;
            case 1:
                [self makeCells:indexPath.row :cell :self.array4ScoreStudents];
                break;
            case 2:
                [self makeCells:indexPath.row :cell :self.array3ScoreStudents];
                break;
            case 3:
                [self makeCells:indexPath.row :cell :self.array2ScoreStudents];
                break;
                
            default:
                break;
        }
        return cell;
    }
    

    
    // this if for master mode
    /*
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
        // pupil-student UITableViewCellStyleDefault
    }
    
    
    APColor* color = [self.arrayColors objectAtIndex:indexPath.row];
    cell.textLabel.textColor = color.color ;
    cell.textLabel.font = [UIFont fontWithName:@"Arial" size:12];
    APStudent* student = [self.arraySortedStudents objectAtIndex:indexPath.row];
    
    // for student
    // cell.textLabel.text = color.name;
    cell.textLabel.text = [NSString stringWithFormat:@"%@,%@", student.firstName, student.lastName];
    
    
    // for master mode
    cell.detailTextLabel.font = [UIFont fontWithName:@"Arial" size:12];
    
    if (student.averageScore < 3) {
        cell.detailTextLabel.textColor = [UIColor redColor];
        cell.detailTextLabel.font = [UIFont fontWithName:@"Arial" size:16];
    } else {
        cell.detailTextLabel.textColor = [UIColor blackColor];
    }
    
    cell.detailTextLabel.text = [NSString stringWithFormat:@" average score is - %.2f", student.averageScore];
    
    
    return cell;
    */
    /* this is for pupil mode
    UIColor* colorForRaw = [self randomColor];
    
    //cell.backgroundColor = colorForRaw;
    
    cell.textLabel.textColor= colorForRaw ;
    
    CGFloat red, green, blue, alpha ;
    
    [colorForRaw getRed:&red green:&green blue:&blue alpha:&alpha ];
    
    cell.textLabel.text = [NSString stringWithFormat:@"COLOR IN RGB {%.2f, %.2f, %.2f}", red, green, blue];
    
    
    
    return cell;
    */
    
  
    
    
    /* this is for Fonts From Lesson of Alex
    static NSString* identifier = @"Cell";
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        NSLog(@"cell created");
    } else {
        NSLog(@"cell resused");
    }
    
    NSArray* familyNames = [UIFont familyNames];
    
    NSString* familyName = [familyNames objectAtIndex:indexPath.section];
    
    NSArray* fontNames = [UIFont fontNamesForFamilyName:familyName];
    
    NSString* fontName = [fontNames objectAtIndex:indexPath.row];
    
    cell.textLabel.text = fontName;
    
    UIFont* font = [UIFont fontWithName:fontName size:9];
    
    cell.textLabel.font = font;
    
    return cell;
    */
    
    
    
    
    
}

#pragma mark - Methods

- (UIColor*) randomColor {
    
    CGFloat r = (CGFloat)(arc4random() % 256) / 255.f;
    CGFloat g = (CGFloat)(arc4random() % 256) / 255.f;
    CGFloat b = (CGFloat)(arc4random() % 256) / 255.f;
    return [UIColor colorWithRed:r  green:g blue:b alpha:1.f];
}

- (void) makeCells:(NSInteger) row : (UITableViewCell*) cell : (NSMutableArray*) array {
    
    APStudent* student = [array objectAtIndex:row];

    cell.textLabel.text = [NSString stringWithFormat:@"%@,%@", student.firstName, student.lastName];
 
    // for master mode
    cell.detailTextLabel.font = [UIFont fontWithName:@"Arial" size:12];
    
    if (student.averageScore < 3) {
        cell.detailTextLabel.textColor = [UIColor redColor];
        cell.detailTextLabel.font = [UIFont fontWithName:@"Arial" size:16];
    } else {
        cell.detailTextLabel.textColor = [UIColor blackColor];
    }
    
    cell.detailTextLabel.text = [NSString stringWithFormat:@" average score is - %.2f", student.averageScore];
}

@end
