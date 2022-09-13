# evolutionMVC
The app tended to show a *Login*, *Register*, and *Main* screen triplet, which is the most common thing in mobile development.

*Disclaimer*: the app does not care about security or proper authorization/authentication. It can but won't decide wether the user has already logged in or not. There is no logout too. The Authentication part just only tends to show the navigation. Furthermore, all the view layouts are implemented until it's usable.

In this repo, every project has different traits to present the different approaches through apps.

## Architectural pattern: MVC

Goo' ole Model-View-Controller triangle. Of course, nobody uses this by now - I mean, I REALLY HOPE 😬 - but I wanted to revisit this approach without transforming the project into the infamous *MassiveViewController*.

### Model

While it's "just" an MVC, we still have the power to separate dedicated services like Network and Persistency logic from the Controller and don't make it a big pile of URLSessioned UserDefaults mess in the ViewController. That would be the real Controller, but come on, you can admit it, this slight change makes this code better, and it's just an initial project for later, more beautiful projects. 

The Model layer doesn't use separation regarding functionality. It means the Model layer has only one model type, NetworkModel. In further example projects, there will be models for Network layer, Domain layer, and at last, UI layer.

### View

Later on - check the **View's built by** part.

### Controller

The ViewController only implements the logic of the controls and views - *UITextField*, *UIButton*, *UITableView* - and navigation. That's why the ViewControllers are the true Controllers in this case. The project also uses two types of approach regarding catching event from the UI. First, setting target method for pressing a button; second, wiring out event of tapping button as IBOutlet from Storyboard to manage events.



## Dependency injection: **On-demand**

Back then, in prehistoric times, there was no real dependency injection, because there was either singleton or locally instantiated objects. This approach implements the On-demand approach where the dependencies of the objects are created immediately when the container objects needs. In the instantiation each and every dependency are getting instantiated through several levels. So say, there is a viewModel which owns a reference of an adaptor which has a reference of a service, then all of those instantiation are needed to make it functional.

## Handling asynchronicity with: **completionHandler**

The "bestest" and quickest solution in low-level for handling delayed answers, responses or return values is closures. The closures are not using any kind of frameworks - neither Apple nor external -, that's why it's the most bulletproof solution if we wish to keep the code resilient against changes. The time has passed and several other options appeared - from Delegate to async-await - but the closures keep remained. Whenever we need a quick and easy tool for postponing information in the data flow, the closure or completionHandler comes in hand and does its job as it needs.

Of course, Because we have several other options for managing asynchronous code, be prepared in other projects.

## View's built by: pure Storyboard

Yet another approach which reminds me my take away tasks at University. It's the easiest way to assemble a few views for a small app to present to your teacher how capable and strong engineer student you are. This approach does not even contain any partial xib or subview that can be referred in ViewController. Everything has been built on the Storyboard and ViewController - no exception. Not even a damn *TableViewCell*.

Nowadays this approach became the stepchild (fie! not those stepchildren who you are thinking of 😬) of layout building mechanism. Because Mobile apps became bigger and bigger we needed to switch from this approach to something different, something less hardwired. So this one is just a demonstration of how we can manage everything through storyboards, but it isn't future-proof or collaborative (especially version control conflict management).

## Navigation with: Segues

Okay, here is no special mumbo-jambo. This is the other pure Apple-ish solution, the Segues. Of course not all the navigation has got Segue implementation, but I could have done it - I was just you know.. lazy to figure out how to solve an issue within a buried technology.

## External dependencies or frameworks: **None**

Wohohohoo, pipe down, little fellow! It's not a sin... yet not to use dependencies. I swear I just wanted to try out how does it feel to solve every issue by myself. **Result**: pain in the ass...essment.

It was a good experiment if I still remember how to create basic communication with URLSessions. 🤷‍♂️ *Weird flex, but ok*

## Dependency Manager: **None**

Due to lack of external dependencies I didn't need to touch any manager like CocoaPods, Carthage or the blissful SPM. Like Kitt had we will have SPM at the end of our road too.

<img src="https://automakett.hu/uploads/shop/automakett.hu/termek/3075216/369313_big.jpg" alt="Aoshima 043554 Knight Rider Knight2000 K.I.T.T. Mode-SPM" style="zoom:50%;" />

## Scheme usage

It was a hard debate in my mind. Should I already introduce Schemes, or may I leave it to the next projects? Nah... I needed. I don't have the mood and time to develop and maintain a backend even though it's an intruiging idea. So that's why I established three different schemes for different approaches.

### Production

So, because I don't have a proper backend. :sad_frontend_developer_noises: the scheme doesn't work. I use a dummy domain which doesn't exist at all and I just don't care about. If it would be a real-life production code, the backend wouldn't be ready with their part anyway... :angry_backend_developer_noises:

![Good, good Let the evil flow through you - Good, good Let the evil flow through you  Happy Emperor Palpatine](http://www.quickmeme.com/img/1b/1be48a823023e07171f1c4d05a814059f77e4bcb783ec6953bb709f626a11b55.jpg)

### Mock

So because I'm an arrogant frontend developer who doesn't need any backend developer guy, I use Mock scheme. Because I know I implement everything perfectly unlike any other developer 😈. No, no... Actually I use it not to care about how the server-client communication should work and I wanted to hide the pain behind of it.

The mock scheme is not a true Mock scheme. :SHOCKING: Because I don't have proper dependency injection logic, just some light-weight disgusting solution, I needed to use compiler directives to distinguish MOCK target code parts from others. So basically I mock the logic inside the exact implementation.

It's not the best approach. I could have implemented other Mock classes by conforming the same protocol and using the directives in the instantiation part, but because I write down a better solution, I don't need to fix it. 

Ha, Gotcha!

### Staging

To be honest, I'm very proud of this solution. The internet community has an npm package, called [stubby4node](https://github.com/mrak/stubby4node). With it I was able to implement a local server which imitating server-client communication without being an *SSJ3 Node.js senior expert engineer developer*. (Yeah, I know I just should have had to implement some *expressjs* and define some controllers and tada.. but you know.. lazy programmer it is). 

So basically stubby4node needs to run and the server is up and running. By referring the local IP and port, it gives back responses by calling the predefined endpoints with the proper data and status that you wait.



## Testing: None

Soooo, yap. No testing at all. Am I a bad person now? 

Nah... admit it.. You hate to write tests too, don't be hypocrite 😏 There will be unit tests in the next projects, it was just a teasing.
