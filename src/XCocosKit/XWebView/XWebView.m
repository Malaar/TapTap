//
//  MyClass.m
//  TapTapRevolution
//
//  Created by Yuriy Bosov on 8/27/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "XWebView.h"
#import "MUAutoresizeButton.h"
#import "CCDirector.h"

//==============================================================================
//==============================================================================
//==============================================================================
@interface XWebView (Private)

- (void) toGameButtonPressed:(id)sender;
- (void) backButtonPressed:(UIBarButtonItem*)sender;
- (void) forwardButtonPressed:(UIBarButtonItem*)sender;
- (void) refreshButtonPressed:(UIBarButtonItem*)sender;
- (void) stopLoading;
- (void) updateButtonToolBar;

@end

//==============================================================================
//==============================================================================
//==============================================================================

@implementation XWebView


#pragma mark - Init/dealloc
//==============================================================================
- (id)initWithURLString:(NSString *)aUrlString
{
    self = [self initWithFrame:CGRectMake(0, 0, 480, 320)];
    if (self)
    {
        [self loadUrlByString:aUrlString];
    }
    return self;
}

//==============================================================================
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) 
    {
        self.backgroundColor = [UIColor clearColor];
        self.exclusiveTouch = YES;
        // bottom toolbar
        bottomToolbar = [self createBottomToolbar];
        [self addSubview:bottomToolbar];
        [bottomToolbar sizeToFit];
        CGRect frame = bottomToolbar.frame;
        frame.origin = CGPointMake(0, self.bounds.size.height - frame.size.height);
        bottomToolbar.frame = frame;
        bottomToolbar.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
        [bottomToolbar setItems:[self bottomToolbarElements]];
        
        // web view
        webView = [[[UIWebView alloc] initWithFrame:CGRectMake(0, 
                                                               0, 
                                                               self.bounds.size.width,
                                                               self.bounds.size.height - bottomToolbar.bounds.size.height)] autorelease];
        webView.delegate = self;
        webView.scalesPageToFit = YES;
        webView.backgroundColor= [UIColor clearColor];    
        [[webView.subviews objectAtIndex:0] setBackgroundColor:[UIColor clearColor]];
        [self addSubview:webView];
        
        // activiti view
        activityIndicator = [[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray] autorelease];
        activityIndicator.center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
        activityIndicator.hidesWhenStopped = YES;
        [activityIndicator stopAnimating];
        [self addSubview:activityIndicator];
    }
    return self;
}


//==============================================================================
- (void)dealloc
{
    [toGameBarButton release];
    [backBarButton release];
    [forwardBarButton release];
    [flexSpace release];
    [fixedSpace release];
    [super dealloc];
}

//==============================================================================
- (void) loadUrlByString:(NSString*)aUrlString
{
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:aUrlString]]];
}

#pragma mark - Bottom Toolbar
//==============================================================================
- (MUToolbar*) createBottomToolbar
{
    MUToolbar*tb = [[[MUToolbar alloc] init] autorelease];
    [tb setBackgroundImage:[UIImage imageNamed:@"assets/graphics/WebToolbar/tool_bar_bg.png"]];
    return tb;
}

//==============================================================================
- (NSArray*) bottomToolbarElements
{        
    // to game button
    MUAutoresizeButton* bt = [MUAutoresizeButton buttonForNavBackByTitleName:@"Game" imageName:@"assets/graphics/WebToolbar/tool_bar_button_back.png"];
    [bt setupFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:12.5f]];
    [bt addTarget:self action:@selector(toGameButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    toGameBarButton = [[UIBarButtonItem alloc] initWithCustomView:bt];
    
    // back button
    backBarButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"assets/graphics/WebToolbar/back.png"]
                                                     style:UIBarButtonItemStylePlain
                                                    target:self  
                                          action:@selector(backButtonPressed:)];
    backBarButton.enabled = NO;
    
    // forvard button
    forwardBarButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"assets/graphics/WebToolbar/forward.png"]
                                                        style:UIBarButtonItemStylePlain
                                                       target:self
                                                       action:@selector(forwardButtonPressed:)];
    forwardBarButton.enabled = NO;
    
    // refresh button
    refreshStopBarButton= [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh 
                                                                        target:webView 
                                                                        action:@selector(reload)] autorelease];
    refreshStopBarButton.enabled = NO;
    
    // spaces
    flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    fixedSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    fixedSpace.width = 15;
    
    NSMutableArray* items = [NSMutableArray arrayWithObjects:toGameBarButton, flexSpace, backBarButton, flexSpace, forwardBarButton, flexSpace, refreshStopBarButton, fixedSpace, nil];
    
    return items;    
}

//==============================================================================
- (void) updateButtonToolBar
{
    backBarButton.enabled = [webView canGoBack];
    forwardBarButton.enabled = [webView canGoForward];
	
	if(webView.loading && !stoppedLoading)
		refreshStopBarButton = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop target:self action:@selector(stopLoading)] autorelease];
	
	else
		refreshStopBarButton = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refreshButtonPressed:)] autorelease];
	
    bottomToolbar.items = [NSMutableArray arrayWithObjects:toGameBarButton, flexSpace, backBarButton, flexSpace, forwardBarButton, flexSpace, refreshStopBarButton, fixedSpace, nil];
}

#pragma mark - Button Actions
//==============================================================================
- (void) toGameButtonPressed:(id)sender
{
    [[[CCDirector sharedDirector] openGLView] setMultipleTouchEnabled:NO];
    [self removeFromSuperview];
}

//==============================================================================
- (void) backButtonPressed:(UIBarButtonItem*)sender
{
    [webView goBack];
    sender.enabled = [webView canGoBack];
}

//==============================================================================
- (void) forwardButtonPressed:(UIBarButtonItem*)sender
{
    [webView goForward];
    sender.enabled = [webView canGoForward];
}

//==============================================================================
- (void) refreshButtonPressed:(UIBarButtonItem*)sender
{
    [webView reload];
}

//==============================================================================
- (void) stopLoading
{
    stoppedLoading = YES;
    [webView stopLoading];
    [activityIndicator stopAnimating];
    [self updateButtonToolBar];
}

#pragma mark - UIWebViewDelegate
//==============================================================================
- (void) webViewDidStartLoad:(UIWebView *)webView
{
    stoppedLoading = NO;;
    [activityIndicator startAnimating];
    [self updateButtonToolBar];
}

//==============================================================================
- (void) webViewDidFinishLoad:(UIWebView *)webView
{
    [activityIndicator stopAnimating];
    [self updateButtonToolBar];
}

//==============================================================================
- (void) webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [self updateButtonToolBar];
}

//==============================================================================
//==============================================================================
//==============================================================================
@end
