# Answers to Technical Questions

1) How long did you spend on the code challenge? What would you add to your solution if you had more time? If you didn't spend much time on the code challenge then use this as an opportunity to explain what you would add.

	I spent about 3.5 days on this code challenge. If given more time, I would build out the rest of the API endpoints, refactor code, include strong params for each controller, and rethink my DB schema to see if I can't reflect better relationships with scale in mind. 

2) What was the most useful feature that was added to the latest version of a language you used? Please include a snippet of code that shows how you've used it.

	N/A - Spoke with point of contact concerning this question.

3) How would you track down a performance issue in production? Have you ever had to do this?

	I would begin by seeing how my server is responding to my requests in order to determine a starting point in troubleshooting. Depending on the issue, I would begin with one starting endpoint and work my way through the MVC cycle in order to further clarify to myself where the problem is coming from. Yes.
	
4) Please describe yourself using JSON

	JSON is a standardized format in which we can return or request objects being sent from a client to a server. Not only does JSON offer a standardized format that is accessible in most technical languages, it also offers authentication ability through JSON web tokens. I utilized JWT in this application in order to correctly authenticate a user and allow only users with appropriate authentication access to information. This standardized format consists of three parts in a given encoded string, all of which are then decoded and returned back to the server in a readable format to return meaningful data to a user.