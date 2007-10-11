// RUN: clang -fsyntax-only -verify %s

@protocol P1 @end
@protocol P2 @end
@protocol P3 @end

@interface INTF 
- (INTF*) METH1;	// expected-error {{previous declaration is here}}
- (INTF<P1>*) METH1;	// expected-error {{duplicate declaration of method 'METH1'}}

- (INTF<P1,P2>*) METH2;
- (INTF<P2,P1>*) METH2;  // expected-error {{previous declaration is here}}
- (INTF<P2,P1,P3>*) METH2;  // expected-error {{duplicate declaration of method 'METH2'}}

- (INTF<P2,P1,P3>*) METH3;
- (INTF<P3,P1,P2, P3>*) METH3;

@end

INTF<P2,P1,P3>* p1;

