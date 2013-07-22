//
//  CodeNameListViewController.m
//  CodeNameGenerator
//
//  Created by Barry Rowe on 7/2/13.
//  Copyright (c) 2013 ElephanTango. All rights reserved.
//

#import "CodeNameListViewController.h"
#import "CodeNameFactory.h"

@interface CodeNameListViewController (){
}
@property (nonatomic, strong) NSArray *codeNames;

- (void) refreshCodeNames;
@end

@implementation CodeNameListViewController

@synthesize codeNames = _codeNames;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        //Do things here if needed. It's probably best to set
        //  on viewDidLoad
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    self.title = @"Code Names";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSLog(@"Number of Sections Called");
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    int count = [[self codeNames] count];
        NSLog(@"Number of Rows in Section called and found %d items", count);
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CodeNameCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    cell.textLabel.text = [[[self codeNames] objectAtIndex:[indexPath row]] name];
    cell.detailTextLabel.text = [[[self codeNames] objectAtIndex:[indexPath row]] summary];
    
    return cell;
}


-(void) tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if(editingStyle == UITableViewCellEditingStyleDelete){
        CodeName *cn = [_codeNames objectAtIndex:[indexPath row]];
        [[CodeNameFactory sharedFactory] removeCodeName:cn];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}
#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //Versiont 2.0 TODO:  Provide modal Edit controller.
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

#pragma mark - View Lifecycle
- (void) viewWillAppear:(BOOL)animated{
    NSLog(@"viewWillAppear Just Fired!");
    [super viewWillAppear:animated];
    [self refreshCodeNames];
    [[self tableView] reloadData];
}

#pragma mark - Custom Logic
- (void) refreshCodeNames{
    _codeNames = [[CodeNameFactory sharedFactory] allCodeNames];
    for (CodeName *cn in _codeNames) {
        NSLog(@"%@", cn);
    }
}

@end
