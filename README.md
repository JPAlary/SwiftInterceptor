# Swift-interceptor

## Introduction

This Interceptor "concept" comes from the Interceptor implementation in the library Okhttp for Android (see [Okhttp interceptor wiki][1]).
This mechanism is very powerful when you want to modify/do some actions on an input object before and after the process it was given for.
See the interceptors as a middleware between the source of your input object and its final destination.

In this Swift implementation, two more things has been added:
- Generic input.
- Asynchronous process: the interceptor does not return the output synchronously but call a closure when it decides the process is done.

With Interceptors, you have:
- clean and robust solution to handle:
	- network monitoring
	- adding parameters for all your requests in a single place
	- authentication (get/refresh a token). Signed your request before sending it.
	- retry failed request
	- and more.. ;)
- clear distribution of roles:
	- each interceptor has a clear purpose
	- do only one thing on the input  object
- an easy way to improve test coverage with unit tests on each of your interceptors

To finish, as it's generic, you can apply this mechanism in another context. Be creative ! :)

## Installation

### Cocoapods

[Cocoapods][2] is a dependency manager for Cocoa projects. You can install it with the command:
```bash
$ gem install cocoapods
```

To add SwiftInterceptor to your project, write in your `Podfile` the following lines:
```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '8.0'
use_frameworks!

target '<Your Target Name>' do
    pod 'SwiftInterceptor'
end
```

Then run in a terminal the command:
```bash
$ pod install
```

## Usage

### Interceptor
First thing to do, it's to create the Interceptor(s) you need. Remember, Interceptor is designed to be used to intercept the input object.
**Group your Interceptors by concern and avoid duplicated ones**

To do so, you just have to conform to the protocol Interceptor:

```swift
protocol Interceptor {
    associatedtype Input
	
	func intercept(chain: InterceptorChain<Input>, completion: (Input) -> Void) -> Void
}
```
#### Example

**Intercept the input**

```swift
struct MyInterceptor: Interceptor {
	func intercept(chain: InterceptorChain<URLRequest>, completion: (URLRequest) -> Void) -> Void {
		// 1) Retrieve the input object (the request)
		var request = chain.input

		// 2) Do things with/on the request

		// 3) Give it back to the chain
		chain.input = request

		// 4) Continue the chaining to others interceptors. /!\ Don't forget to call this, if you don't, you will get stuck in this interceptor.
		chain.proceed(completion: completion)
	}
}
```

### Interceptor chain
--------

When you have your interceptors implemented, it's finished ! 

To launch the process:

```swift
// 1) I create an instance of interceptor chain. You can add many interceptor you want.
let chain = InterceptorChain()
	.add(interceptor: AnyInterceptor(base: MyInterceptor()))
chain.input = request

// 2) Launch the process
chain.proceed { (request) in
	// 3) I get my request intercepted by all the interceptors
}
```

## Additional informations

For more explanations about the interceptor mechanism, don't hesitate to read the documentation in the [okhttp wiki][1].
For RxSwift fans, there is the same implementation with RxSwift, see [SwiftRxInterceptor][3].

[1]: https://github.com/square/okhttp/wiki/Interceptors
[2]: https://cocoapods.org/
[3]: https://github.com/JPAlary/SwiftRxInterceptor
