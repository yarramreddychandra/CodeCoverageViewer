public with sharing class CodeCoverageViewerController {
	public ApexCodeCoverageAggregateResult result {get; set;}

	public PageReference doInit(){
		String response = sendQueryRequest('SELECT+ApexClassOrTriggerId,ApexClassOrTrigger.Name,NumLinesCovered,NumLinesUncovered+FROM+ApexCodeCoverageAggregate+WHERE+ApexClassOrTriggerId!=NULL+AND+ApexClassOrTrigger.Name!=NULL+AND+(NumLinesCovered>0+OR+NumLinesUncovered>0)+AND+NumLinesCovered!=NULL+AND+NumLinesUncovered!=NULL+ORDER+BY+ApexClassOrTrigger.Name');
		this.result = (apexCodeCoverageAggregateResult)JSON.deserialize(response, apexCodeCoverageAggregateResult.class);
		return null;
	}

	private String sendQueryRequest(String query){
		HttpRequest req = new HttpRequest();
		req.setEndpoint(URL.getSalesforceBaseUrl().toExternalForm() + '/services/data/v35.0/tooling/' + 'query/?q=' + query);
		req.setHeader('Authorization', 'Bearer ' + UserInfo.getSessionID());
		req.setHeader('Content-Type', 'application/json');
		req.setMethod('GET');
		Http http = new Http();
		HTTPResponse res = http.send(req);
		return res.getBody();
	}

	public class ApexCodeCoverageAggregateResult {
		public Integer size {get; set;}
		public Integer totalSize {get; set;}
		public Boolean done {get; set;}
		public Object queryLocator {get; set;}
		public String entityTypeName {get; set;}
		public List<Records> records {get; set;}
	}
	
	public class ApexCodeCoverageAggregateResults {
		
	}

	public class Records {
		public Attributes attributes {get; set;}
		public String ApexClassOrTriggerId {get; set;}
		public ApexClassOrTrigger ApexClassOrTrigger {get; set;}
		public Integer NumLinesCovered {get; set;}
		public Integer NumLinesUncovered {get; set;}
	}

	public class ApexClassOrTrigger {
		public Attributes attributes {get; set;}
		public String Name {get; set;}
	}

	public class Attributes {
		public String type {get; set;}
		public String url {get; set;}
	}

}
