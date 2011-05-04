//
//  XPathQuery.h
//  FuelFinder
//
//  Created by Matt Gallagher on 4/08/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

NSMutableArray *PerformHTMLXPathQuery(NSData *document, NSString *query);
NSMutableArray *PerformXMLXPathQuery(NSData *document, NSString *query);