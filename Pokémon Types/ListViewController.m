//
//  ThirdViewController.m
//  Pokémon Types
//
//  Created by Andrew Clissold on 10/10/13.
//  Copyright (c) 2013 Andrew Clissold. All rights reserved.
//

#import "ListViewController.h"

@interface ListViewController () {
    NSArray *pokemon;
}

@end

@implementation ListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    pokemon = @[@"Alakazam", @"Beedril", @"Combee", @"Drapion",
                @"Etc."];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [pokemon count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    cell.textLabel.text = [pokemon objectAtIndex:(long)indexPath.row];
    return cell;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
