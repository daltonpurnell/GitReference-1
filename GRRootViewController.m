//
//  GRRootViewController.m
//  GitReference
//
//  Created by User on 3/31/15.
//  Copyright (c) 2015 DevMountain. All rights reserved.
//

#import "GRRootViewController.h"

// set a global margin (say 15) so that your text doesn't butt up against the edges of the screen
static CGFloat margin = 15;

// set the height of the labels to 20
static CGFloat heightForLabel = 20;


static NSString * const Command = @"command";
static NSString * const Reference = @"reference";

@interface GRRootViewController ()

@end

@implementation GRRootViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization (copied this from solution code, but I'm not exactly sure what it does)
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Give the scrollView a y of 20 so that it doesn't collide with the status bar.
    CGFloat topMargin = 20;
    
    // Give some space between the side edges of the scrollView and the sides of the View
    CGFloat widthMinusMargin = self.view.frame.size.width - 2 * margin;
    
    // Add a scrollView to the main view
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, self.view.frame.size.height - 20)];
    [self.view addSubview:scrollView];
    
    // Add a title ("GitReference") to the scrollView
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(margin, topMargin, widthMinusMargin, heightForLabel)];
    title.text = @"GitReference";
    [scrollView addSubview:title];
    
    // Make the font bold size 20
    title.font = [UIFont boldSystemFontOfSize:20];
    
    
    // Set the top of the scrollView to equal the global margin + the label height + the top margin, and then multiply it by 2
    CGFloat top = topMargin + heightForLabel + margin * 2;
    
    // Add a for loop to iterate through the dictionaries in the gitCommands method provided
    for (NSDictionary *gitCommand in [self gitCommands])
        
    {
        NSString *command = gitCommand[Command];
        NSString *reference = gitCommand[Reference];
        
        
        // Create a command label and add it to the view
        UILabel *Command = [[UILabel alloc] initWithFrame:CGRectMake(margin, top, widthMinusMargin, heightForLabel)];
        Command.text = command;
        Command.font = [UIFont boldSystemFontOfSize:17];
        [scrollView addSubview:Command];
        
        // Track the top of each label as you iterate through the git commands and add to it each time you want to move further down in the scrollView
        top += (heightForLabel + margin);
        
        CGFloat heightForReference = [self heightOfReferenceString:reference];
        
        
        // Create a reference label and add it to the view just below the command
        UILabel *Reference = [[UILabel alloc] initWithFrame:CGRectMake(margin, top, widthMinusMargin, heightForReference)];
        Reference.text = reference;
        Reference.numberOfLines = 0;
        Reference.font = [UIFont systemFontOfSize:15];
        [scrollView addSubview:Reference];
        
        // Track the top of each label as you iterate through the git commands and add to it each time you want to move further down in the scrollView
        top += (heightForReference + margin * 2);
    }
    
    // Update the scrollView's contentSize to the height of all of the labels combined (including margins)
    scrollView.contentSize = CGSizeMake(self.view.frame.size.width, top);
    
}

// instance method copied from GitHub
- (NSArray *)gitCommands {
    
    return @[@{Command: @"git status", Reference: @": shows changed files"},
             @{Command: @"git diff", Reference: @": shows actual changes"},
             @{Command: @"git add .", Reference: @": adds changed files to the commit"},
             @{Command: @"git commit -m \"notes\"", Reference: @": commits the changes"},
             @{Command: @"git push origin _branch_", Reference: @": pushes commits to branch named _branch_"},
             @{Command: @"git log", Reference: @": displays progress log"},
             @{Command: @"git comment --amend", Reference: @": re-enter last commit message"}
             ];
    
}

// instance method copied from GitHub
- (CGFloat)heightOfReferenceString:(NSString *)reference {
    
    CGRect bounding = [reference boundingRectWithSize:CGSizeMake(self.view.frame.size.width - 2 * margin, 0)
                                              options:NSStringDrawingUsesLineFragmentOrigin
                                           attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]}
                                              context:nil];
    
    return bounding.size.height;
    
}

@end

