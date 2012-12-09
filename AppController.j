/*
 * AppController.j
 * TestBindings
 *
 * Created by You on December 5, 2012.
 * Copyright 2012, Your Company All rights reserved.
 */

@import <Foundation/CPObject.j>
@import <Ratatosk/Ratatosk.j>
@import "Controllers/ProjectController.j"

DidFinishLoadingNotification = @"DidFinishLoadingNotification";

@implementation AppController : CPObject
{
    CPWindow    theWindow; //this "outlet" is connected automatically by the Cib
}

- (void)applicationDidFinishLaunching:(CPNotification)aNotification
{
    // This is called when the application is done loading.
    projectController = [[ProjectController alloc] init];
    [projectController fetchProjects];
}

- (void)awakeFromCib
{
    CPLogRegister(CPLogConsole);
    [WLRemoteLink setDefaultBaseURL:@""];
    [[CPNotificationCenter defaultCenter] addObserver:self
                                          selector:@selector(didFinishLoading:)
                                          name:DidFinishLoadingNotification
                                          object:nil];
    // This is called when the cib is done loading.
    // You can implement this method on any object instantiated from a Cib.
    // It's a useful hook for setting up current UI values, and other things.

    // In this case, we want the window from Cib to become our full browser window
    [theWindow setFullPlatformWindow:YES];
}

- (void)didFinishLoading:(id)aNotification
{
    CPLog("Hurrah! I'm done loading");
}

@end


@implementation Project : WLRemoteObject
{
    CPString projectName;
    CPString projectDescription;
    CPString resourceURI;
}

- (Project)init
{
    if (self = [super init])
    {
        CPLog("Initializing Project Model");
        projectName = @"Foo";
        projectDescription = @"my great description";
    }
    return self;
}

+ (CPArray)remoteProperties
{
    return [
        ['pk', 'url'],
        ['projectName', 'name'],
        ['projectDescription', 'description'],
        ['resourceURI', 'url']
    ];
}

@end
