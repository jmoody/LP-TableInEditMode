#import "LjsViewController.h"

static CGFloat const heightOfRow = 49;

@interface UIColor (UIColor_LjsAdditions)
+ (UIColor *) colorWithR:(CGFloat) r g:(CGFloat) g b:(CGFloat) b;
@end

@implementation UIColor (UIColor_LjsAdditions)

+ (UIColor *) colorWithR:(CGFloat) r g:(CGFloat) g b:(CGFloat) b {
  return [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0];;
}

@end

@interface LjsViewController ()

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *array;


@end

@implementation LjsViewController

@synthesize tableView;
@synthesize array;

- (void)viewDidUnload {
  [super viewDidUnload];
  
}

- (void)viewDidLoad {
  [super viewDidLoad];
  CGRect rect = CGRectMake(0, 0, 320, 460-44-49);
  
  UITableViewStyle style = UITableViewStylePlain;
  self.tableView  = [[UITableView alloc] initWithFrame:rect
                                                 style:style];
  
  self.tableView.bounds = rect;
  
  self.tableView.backgroundColor = [UIColor colorWithR:247 g:247 b:247];
  [self.tableView setAutoresizesSubviews:YES];
  [self.tableView setAutoresizingMask:(UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight)];
  self.tableView.delegate = self;
  self.tableView.dataSource = self;
  
  self.tableView.sectionFooterHeight = 0.0;
  self.tableView.sectionHeaderHeight = 0.0;
  
  self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
  UIColor *lineColor = [UIColor blackColor];
  [self.tableView setSeparatorColor:lineColor];
  self.tableView.accessibilityIdentifier = @"table";
  self.tableView.tag = 3030;
  
  [self.view addSubview:self.tableView];
  
  self.array = [NSArray arrayWithObjects:@"a", @"b", @"c", @"d", @"e", @"f", @"g", @"h", @"i", @"j", @"k", @"l", @"m", @"n", @"o", @"p", nil];
  
  [self.navigationItem setRightBarButtonItem:self.editButtonItem];
  self.editing = NO;
}

- (void) setEditing:(BOOL) aEditing animated:(BOOL) aAnimated {
  NSLog(@"edit button touched");
  [super setEditing:aEditing animated:aAnimated];
  [self.tableView setEditing:aEditing animated:YES];
}

#pragma mark UITableViewDataSource

- (NSInteger) tableView:(UITableView *) aTableView numberOfRowsInSection:(NSInteger) aSection {
  return [self.array count];
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *) aTableView {
  return 1;
}

- (UITableViewCell *) tableView:(UITableView *) aTableView cellForRowAtIndexPath:(NSIndexPath *) aIndexPath {
  UITableViewCell *cell;
  NSString *identifier = [NSString stringWithFormat:@"%d:%d", aIndexPath.section, aIndexPath.row];
  cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                reuseIdentifier:identifier];
  NSString *text = [self.array objectAtIndex:aIndexPath.row];
  NSString *accessId = [NSString stringWithFormat:@":%@", text];  
  
  NSIndexPath *selectedIndex = [aTableView indexPathForSelectedRow];
  if (selectedIndex != nil && selectedIndex.row == aIndexPath.row) {
    cell.textLabel.text = @"selected";
  } else {
    cell.textLabel.text = text;
  }
  cell.accessibilityIdentifier = accessId;
  cell.textLabel.accessibilityIdentifier = [NSString stringWithFormat:@"label"];
  return cell;
}

#pragma mark UITableViewDataSource Inserting or Deleting Table Rows

- (void) tableView:(UITableView *) aTableView commitEditingStyle:(UITableViewCellEditingStyle) editingStyle 
 forRowAtIndexPath:(NSIndexPath *) aIndexPath {
  
}

- (BOOL) tableView:(UITableView *) aTableView canEditRowAtIndexPath:(NSIndexPath *) aIndexPath {
  return YES;
}

#pragma mark UITableViewDataSource Reordering Table Rows

- (BOOL) tableView:(UITableView *) aTableView canMoveRowAtIndexPath:(NSIndexPath *) aIndexPath {
  return YES;
}

- (void) tableView:(UITableView *) aTableView moveRowAtIndexPath:(NSIndexPath *) atIndexPath 
       toIndexPath:(NSIndexPath *) toIndexPath {
  
}

#pragma mark  UITableViewDataSource Uncommon 

//- (NSArray *) sectionIndexTitlesForTableView:(UITableView *) aTableView {
//  
//}
//
//- (NSInteger) tableView:(UITableView *) aTableView sectionForSectionIndexTitle:(NSString *) aTitle 
//                atIndex:(NSIndexPath *) aIndexPath {
//  
//}

#pragma mark UITableViewDelegate 


#pragma mark UITableViewDelegate  Providing Table Cells for the Table View

- (CGFloat) tableView:(UITableView *) aTableView heightForRowAtIndexPath:(NSIndexPath *) aIndexPath {
  return heightOfRow;
}

- (void) tableView:(UITableView *) aTableView willDisplayCell:(UITableViewCell *) aCell 
 forRowAtIndexPath:(NSIndexPath *) aIndexPath {
  [aCell setBackgroundColor:[UIColor colorWithR:247 g:247 b:247]];
}

#pragma mark UITableViewDelegate Modifying the Header and Footer of Sections

//- (UIView *) tableView:(UITableView *) aTableView viewForHeaderInSection:(NSInteger) aSection {
//  
//}
//
//- (UIView *) tableView:(UITableView *) aTableView viewForFooterInSection:(NSInteger) aSection {
//  
//}
//
//- (CGFloat) tableView:(UITableView *) aTableView heightForHeaderInSection:(NSInteger) aSection {
//  
//}
//
//- (CGFloat) tableView:(UITableView *) aTableView heightForFooterInSection:(NSInteger) aSection {
//  
//}

#pragma mark UITableViewDelegate Managing Selections

- (NSIndexPath *) tableView:(UITableView *) aTableView willSelectRowAtIndexPath:(NSIndexPath *) aIndexPath {
  NSIndexPath *selected = [aTableView indexPathForSelectedRow];
  if (selected != nil) {
    UITableViewCell *cell = [aTableView cellForRowAtIndexPath:selected];
    cell.textLabel.text = [self.array objectAtIndex:selected.row];
    [aTableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:selected]
                      withRowAnimation:UITableViewRowAnimationAutomatic];
  }
  return aIndexPath;
}

- (void) tableView:(UITableView *) aTableView didSelectRowAtIndexPath:(NSIndexPath *) aIndexPath {
  
  UITableViewCell *cell = [aTableView cellForRowAtIndexPath:aIndexPath];
  cell.textLabel.text = @"selected";
}

//- (NSIndexPath *) tableView:(UITableView *) aTableView willDeselectRowAtIndexPath:(NSIndexPath *) aIndexPath {
//  
//}

//- (void) tableView:(UITableView *) aTableView didDeselectRowAtIndexPath:(NSIndexPath *) aIndexPath {
//  
//}

#pragma mark UITableViewDelegate Managing Accessory Views

//- (void) tableView:(UITableView *) aTableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *) aIndexPath {
//  
//}


#pragma mark UITableViewDelegate Editing Table Rows

//- (NSInteger) tableView:(UITableView *) aTableView indentationLevelForRowAtIndexPath:(NSIndexPath *) aIndexPath {
//  
//}

//- (void) tableView:(UITableView *) aTableView willBeginEditingRowAtIndexPath:(NSIndexPath *) aIndexPath {
//  
//}

//- (void) tableView:(UITableView *) aTableView didEndEditingRowAtIndexPath:(NSIndexPath *) aIndexPath {
//  
//}

- (UITableViewCellEditingStyle) tableView:(UITableView *) aTableView editingStyleForRowAtIndexPath:(NSIndexPath *) aIndexPath {
  return UITableViewCellEditingStyleDelete;
}

//- (NSString *) tableView:(UITableView *) aTableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *) aIndexPath {
//  
//}

- (BOOL) tableView:(UITableView *) aTableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *) aIndexPath {
  return YES;
}

#pragma mark UITableViewDelegate Reordering Table Rows

//- (NSIndexPath *) tableView:(UITableView *) aTableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *) atIndexPath
//        toProposedIndexPath:(NSIndexPath *) toIndexPath {
//  
//}

@end
