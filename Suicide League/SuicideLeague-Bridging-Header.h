//
//  SuicideLeague-Bridging-Header.h
//  Suicide League
//
//  Created by John Cederholm on 8/5/17.
//  Copyright © 2017 d2i LLC. All rights reserved.
//

#import <libxml/HTMLtree.h>
#import <libxml/HTMLparser.h>
#import <libxml/xpath.h>
#import <libxml/xpathInternals.h>
#import <libxml/xmlerror.h>

static inline UInt32 xmlElementTypeToInt(xmlElementType type) {
    return (UInt32) type;
}
