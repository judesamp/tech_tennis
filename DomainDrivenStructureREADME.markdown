# Domain Driven Application Structure 

This structure builds upon basic concepts of model-view-controller designs, but with a few key layer abstractions and clearer separation of concerns where I felt they were needed. It's broken into three primary design areas:

### Domain

The contains application behavior only. It does not deal with persistence, and it does not deal with controllers or views. Instead, we use two different varieties of models.

* Entities - these are the typical single objects which represent the noun components of your app (ie. People, Places, Things, Books, Cars, etc.)

* Services - these are objects which deal with processing which may or may not utilize entity objects (ie. Registration, FundsTransfer, SocialNetworkShare, etc.)

### Implementation

This is where routing and view behavior goes. We use Rack to mount -- usually based on root uri pattern -- various apps (ie. Implementation::Web, Implementation::Admin, Implementation::Mobile, Implementation::API::V1, etc.) each of which implement the Domain for their own purposes.

Inside the Implementation directory resides a sub-directory each app with, at minimum, an {appname}_implementation.rb file which in most cases is an instance of a Sinatra::Base application (but it could just as easily be a nested Rails app).

Many applications may need little more than this file with a single GET request method to an index -- for instance, in the case where you may be loading a JavaScript framework like ExtJS, SenchaTouch, Backbone.js, etc. The index would simply load the JavaScript application, which would take over from that point forward.

In other cases, you may be developing an interface that is heavy on features -- for instance, a public JSON API (likely what you'd be using in your JavaScript framework to access Domain data anyway, and likewise in a web app which heavily leverages jQuery). In this case, we break out into several Sinatra::Base files based on the features they satisfy. These go into the app's "/routes" sub-directory.

In the case of an API, we don't need view templates or logic. Instead, we use ROAR representers (which provides nice input and output parsing, as well as, HAL compatibility). But, you could optionally use RABL, Grape or the API helper library of choice. Or you could simply have Sinatra spit out .to_json formatted data. The choice is yours.

For typical web views, however, we need to deal with view logic and templating. You could do this with erb, or better yet, HAML. But this exposes another problem often found in many MVC systems... no separation between templating and view logic. To solve this, we use Mustache. We have the following two sub-directories:

  ./implementation/myapp/templates/
  ./implementation/myapp/views/

Templates hold our Mustache templates and partials, which are just standard HTML5 with {{}} around variables which are inserted without knowledge of the underpinnings of the Domain.

Views hold actual classes of view logic. These are how you control what goes into your templates. They contain any formatting of raw data for display, logic which determines what a user sees and anything else which is strictly an aspect of the view. The huge side benefit of this approach is view logic becomes very easy to test with Rspec, whereas it would have been very difficult in an ERB situation.

### Persistence

Database stuff only. This supplies various database abstraction tactics through a consistent API on which the Domain layer can rely. It allows you to swap between database and abstraction tools as needed without creating painful changes within the Domain. Instead of classes which directly represent models, these instead represent the needs of the database in question.

For instance, let's assume the Domain has a concept of a Player. The persistence layer could store player data across several tables as makes sense from the standpoint of normalization, optimization, composite keys, etc. So long as the Domain has only one point of access on the persistence layer per entity, the business of the database is abstracted from the domain. This separation make it easier to change DB selection at any point in the development process without affecting the behavior of your application.

To distinguish the Persistence layer classes from the Domain, we name them like so:

Domain Class - Player.rb  
Data Class - PlayerData.rb  

## Test-Driven Domain Design

One of the biggest gains resulting from these various layers of separation is their independence from any framework. This means we can write spec tests for each layer, and being plain Ruby, those test run incredibly fast. This is critical to insure the test-first process does not become a burden as the codebase grows. 

You can write cucumber acceptance tests to check behavior of the full stack, but I generally recommend doing acceptance testing on an API server, as it covers the most critical and central point of your family of applications. This also gives you the best perspective as an outsider into your Domain, how its entities and services should be named and how each API endpoint should behave. 

Focusing acceptance testing on the API also forces you to write cucumber features which are not brittle, since you are only testing JSON data. The opposite is often true of features running against the DOM by checking against template elements, or worse, text which is returned by a template. You never want a trivial change to a layout to break a test when the behavior you intend to test still works properly. Test upkeep quickly becomes annoying and unwieldy (therefore, you are less likely to do it).


### The Test-Driven Process

The basic premise of test-first design is:

1. Write test
2. Run the tests, which fail
3. Write the code which makes the tests pass

While there are no hard and fast rules with regard to the testing process, I've been working for a while on what seems for me to the be most productive process. At the start of development, the goal of test driven development is to point you clearly in the direction you need to be going, and enable you to write clear and concise code which satisfies the needs of the app. What you gain in the end from test-driven development is the confidence of your test coverage which allows you to make sweeping changes to your application without fear of breaking everything.

The problem I've had with testing over the years is that progress is often stymied by: having too many unrelated concerns being covered in the same place; reliance on tests which bootstrap frameworks, and therefore run slow; and forced assumptions in order to get a test passing. To counteract these tendencies, we therefore respectively: unit test different layers of our application independently by stubbing interaction with interacting layers which are outside the concerns of the test; write our tests in "plain ruby" with as little interaction with libraries and frameworks as possible; and we kick the can down the road when we feel assumptions for one layer are being forced by another. You'll see a lot of that "kick the can" mentality described below.

Generally, I suggest beginning with the API server and branching out from there in either directions (inward to Domain and Persistence, outward to View):

#### STEP ONE - API Server Acceptance Test Drafting

Write a simple cucumber feature for an API server endpoint with scenarios outlining the various expectations you have for that endpoint's behavior. Include the specific format of JSON data both incoming and outgoing from the API _(see included examples in the '/features' directory)_. 

For now, this process is acting as your initial specification for the endpoint and, just as important, the process forces you to think about how an external application, including your user interface(s) will expect to deal with the API. It makes you ask important questions up front about how the resources in your system will be named and expected to behave from the central point of the data, the API server, which all implementations will use.

We aren't going to bother running this test or working on the step definitions needed to make this feature run just yet. Since acceptance testing tests the full stack of your application, it runs very slow. Also, there will be a lot of code which needs to be written to make even the most basic acceptance test pass. So, once we solidify the concepts here, we move on. We will come back to this testing layer later. __Kick the _passing acceptance test_ can__. 


#### STEP TWO - Domain Unit Testing

Next, we jump into Rspec and start writing unit tests for the entities and services of our Domain as outlined in the acceptance test _(I like to keep these in spec/domain/entities and spec/domain/services)_. These should begin as lean as possible, dealing at first with only the aspects of the object which will be exposed to the API server. Write tests for each public attribute which should be surfaced on the API. Write any critical validation needed for data received by the API server (posts, puts, patches). And if you think of any critical business criteria which will needs to happen in the Domain, you can write those tests as well. An example of this would be writing a test for a calculation on the object's data which will be exposed to the API server as an attribute (ie. calculating a percentage of a "revenue" attribute to create a "commission" attribute).

Write these tests, run them, they will fail, write as little code as possible to make them pass. Done. Move on.

Note: What you want to avoid writing in the Domain layer are any considerations over the database (Persistence) used. That will take place, as you might have guessed, in the _Persistence Testing_. At first, you may not even want to decide what database and ORM you use for the application. We don't know enough about our needs yet. We can write a lot of behavior without needing to store data yet. __Kick the _persistence_ can__.

#### STEP THREE - API Server Routes Unit Testing

Our API server controllers, usually Sinatra::Base applications, are intentionally lean. They really only do two basic things: 

1. Retrieve data from the Domain to hand off to the front end.
2. Deal with routing exceptions

Therefore, testing here will also be fairly lean. Test that the route responds to the uri you expect, test that it can access the data it needs, and test that when it runs into a problem it responds in a useful way for the end user (deal with exceptions).

Write these tests, run them, they will fail, write as little code as possible to make them pass. Done. Move on.

#### STEP FOUR - API Server Representers and Our First Working Acceptance Test

You could very easily use Ruby's to_json method as provided to spit out perfectly fine json right from your Sinatra:Base app. But let's stop and think about what that. It means you expect to expose every public attribute of your Domain object to the server API. That may be true, but it likely won't always be the case. Different front-end user interfaces will likely have different uses and intentions. An administrator interface may very well expect to utilize all the objects data, but that probably will not be true of a public web interface.

Often, in MVC systems, this problem gets solved in the Model. But the outside world is not a concern of the model, so we don't want to muddy our Domain with those concerns. There have been several small API server framework or library solutions for solving this (RABL, Grape, etc.), but the one we find most elegant and unassuming of your application design is the ROAR, a framework-agnostic REST framework.

With ROAR, we create Representers, which we can extend our Domain objects with on the fly to apply expectations to the attributes shared and structure of our json data. So, for example, you can create a PostAdminRepresenter and a PostPublicRepresenter to provide separate GET data and accepted POST data for the same Post object. It also has some nice features like HAL resource links (which we'll cover later) and the ability to parse not only outgoing data to json, but incoming json data back into Ruby at the same time.

So, next, we write a representer for our API server endpoint which satisfies the json expectations outlined in our acceptance test back in step one. Now, we run our acceptance test and see where it breaks. If you've caught everything in each stage so far, it likely will only be failing on the issue of persistence... we have no data.

#### STEP FIVE - Persistence Implementation and Testing

Now...