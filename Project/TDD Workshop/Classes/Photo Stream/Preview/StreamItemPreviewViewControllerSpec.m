#import "Specs.h"
#import "StreamItemPreviewViewController.h"
#import "StreamItemPreviewLayout.h"

SPEC_BEGIN(StreamItemPreviewViewControllerSpec)
describe(@"StreamItemPreviewViewController", ^{

    __block StreamItemPreviewViewController *streamItemPreviewViewController;

    beforeEach(^{
        streamItemPreviewViewController = [StreamItemPreviewViewController new];
    });

    afterEach(^{
        streamItemPreviewViewController = nil;
    });

    describe(@"when view is loaded", ^{

        it(@"should be collection view", ^{
            expect(streamItemPreviewViewController.view).to.beKindOf([UICollectionView class]);
        });

        it(@"should have white background color", ^{
            expect(streamItemPreviewViewController.view.backgroundColor).to.equal([UIColor whiteColor]);
        });

        it(@"should have custom layout", ^{
            UICollectionView *collectionView = (UICollectionView *) streamItemPreviewViewController.view;
            expect(collectionView.collectionViewLayout).to.beKindOf([StreamItemPreviewLayout class]);
        });

        it(@"should have paging enabled", ^{
            //Hint: check pagingEnabled property on collection view
            UICollectionView *collectionView = (UICollectionView *) streamItemPreviewViewController.view;
            expect(collectionView.pagingEnabled).to.beTruthy();
        });

        it(@"should be horizontally scrollable", ^{
            //Hint: check scrollDirection on flow layout
            UICollectionView *collectionView = (UICollectionView *) streamItemPreviewViewController.view;
            UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *) collectionView.collectionViewLayout;
            expect(layout.scrollDirection).to.equal(UICollectionViewScrollDirectionHorizontal);
        });
    });

});
SPEC_END