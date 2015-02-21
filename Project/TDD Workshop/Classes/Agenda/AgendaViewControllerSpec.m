#import "Specs.h"

#import "AgendaViewController.h"
#import "AgendaProvider.h"
#import "AgendaTableViewCell.h"
#import "FakeTableView.h"
#import "FakeAgendaProvider.h"


SPEC_BEGIN(AgendaViewController)

describe(@"AgendaViewController", ^{
    __block AgendaViewController *viewController;
    
    beforeEach(^{
        viewController = [[AgendaViewController alloc] init];
    });

    describe(@"object setup", ^{
        it(@"should have instance of Agenda Provider", ^{
            expect(viewController.agendaProvider).to.beKindOf([AgendaProvider class]);
        });
    });

    describe(@"title", ^{
        it(@"should be set to 'Agenda'", ^{
            expect(viewController.title).to.equal(@"Agenda");
        });
    });
    
    describe(@"tab bar item", ^{
        it(@"should have a agenda image", ^{
            expect(viewController.tabBarItem.selectedImage).to.equal([UIImage imageNamed:@"agenda.png"]);
        });
        
        it(@"should have a 'Agenda' title", ^{
            expect(viewController.tabBarItem.title).to.equal(@"Agenda");
        });
    });
    
    describe(@"view loads", ^{
        __block FakeAgendaProvider *provider;
        beforeEach(^{
            provider = [FakeAgendaProvider new];
            viewController.agendaProvider = provider;
        });

        it(@"should reload agenda", ^{
            [viewController viewDidLoad]; // lub viewDidLoad
            expect([provider reloadAgendaCalled]).to.beTruthy();

        });

        context(@"when agenda reloading completes", ^{
            __block FakeTableView *fakeTableView;
            beforeEach(^{
                // arrange
                fakeTableView = mock([UITableView class]);


                // act
                viewController.view = fakeTableView;
                [viewController viewDidLoad];
            });
            it(@"should reload table view", ^{
                // symulujemy asynchroniczna symulacje
                [provider simulateSuccessWithItems:@[]];

                [verify(fakeTableView) reloadData];




            });
        });
    });
    
    describe(@"table view", ^{
        __block UITableView *tableView;
        beforeEach(^{
            tableView = viewController.tableView;
        });
        
        it(@"should have 1 section", ^{
            NSInteger numberOfSections = [viewController.tableView numberOfSections];
            expect(numberOfSections).to.equal(1);
        });
        
        it(@"should have 0 rows", ^{
            expect([tableView.dataSource tableView:tableView numberOfRowsInSection:0]).to.equal(0);
        });
    });
    
    afterEach(^{
        viewController = nil;
    });
});

SPEC_END
