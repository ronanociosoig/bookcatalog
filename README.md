# bookcatalog

Sample project to parse a web service providing details of a list of qualifications (SAT, Junior Cert.), their subjects / content.

The web service returns an etag header, and this is used for subsequent requests. 

Networking is based on NSURLSession, and wraps this to give a simple to use interface where you only specify the URL and parameters. The response is asynchronous and updated the view after is it parsed. 

The response is also cached in NSUserDefaults. 

Unit testing covers most of the model implementation. 

In the table view controllers, the data sources are implemeted as separate classes, and for the table view cells they have a cell model class that encapsulates the processing required to display the data.
