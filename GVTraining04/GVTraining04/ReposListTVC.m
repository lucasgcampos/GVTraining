//
//  ReposListTVC.m
//  GVTraining04
//
//  Created by Cassiano Monteiro on 17/06/16.
//  Copyright © 2016 Guichê Virtual. All rights reserved.
//

#import "ReposListTVC.h"
#import "DetailTVCTableViewController.h"

@interface ReposListTVC ()
@property (nonatomic, strong) NSArray<NSDictionary<NSString *, NSString *> *> *repoList;
@property (nonatomic, strong) NSDictionary<NSString *, NSString *> *itemSelected;
@end

@implementation ReposListTVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // Inicializar array com zero objetos para que a tabela comece com nenhum dado exibido na tela
    self.repoList = @[];
}

- (void)viewDidAppear:(BOOL)animated
{
    [self.activityIndicator startAnimating];
    
    // Rodar em background
    dispatch_async(dispatch_queue_create("queue", nil), ^{
        
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.github.com/users/%@/repos", self.username]];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        NSData *responseBody = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
        self.repoList = [NSJSONSerialization JSONObjectWithData:responseBody options:0 error:nil];
        
        // Voltar a rodar na thread principal, onde a interface é atualizada
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.activityIndicator stopAnimating];
            [self.tableView reloadData];
        });

    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    // Isto é usado para transferir objetos entre telas durante a transição do segue.
    if ([segue.identifier isEqualToString:@"ShowUserReposDetailSegue"]){
        
        DetailTVCTableViewController *detail = segue.destinationViewController;
        detail.selected = self.itemSelected;
    }
}


#pragma mark - <UITableViewDataSource>

// Método obrigatório para informar à tableView quantas linhas existem na fonte de dados a serem exibidos
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.repoList.count;
}

// Método obrigatório para compor os dados exibidos em uma linha da tabela a partir da fonte de dados.
// A linha desta célula é obtida com o indexPath
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RepoCell"];
    
    if ([self.repoList[indexPath.row][@"language"] isKindOfClass:[NSString class]]) {
       cell.detailTextLabel.text = self.repoList[indexPath.row][@"language"]?:@"";
    }
    else {
      cell.detailTextLabel.text = @"";  
    }
    
    return cell;
}

-(NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.itemSelected = self.repoList[indexPath.row];
    return indexPath;
}

@end
