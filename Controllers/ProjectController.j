@import <AppKit/AppKit.j>

@implementation ProjectController : CPObject
{
    @outlet     CPArrayController projectArrayController;
}

- (id)init
{
    if (self = [super init])
    {
        projectArrayController = [[CPArrayController alloc] init];
    }
    return self;
}

- (void)fetchProjects
{
    [WLRemoteAction schedule:WLRemoteActionGetType path:"/projects/" delegate:self message:"Loading projects"];
}

- (void)remoteActionDidFinish:(WLRemoteAction)anAction
{
    CPLog("Did Finish Remote Action");
    p = [Project objectsFromJson:[anAction result].results];
    [projectArrayController addObjects:p];

    CPLog("Number of Projects in Array Controller: " + [[projectArrayController contentArray] count]);

    [[CPNotificationCenter defaultCenter] postNotificationName:DidFinishLoadingNotification
                                          object:nil];
}

@end
