
package net.semwebprogramming.chapter2.HelloSemanticWeb;

import java.io.IOException;
import java.io.InputStream;
import java.util.Iterator;
import org.mindswap.pellet.jena.PelletReasonerFactory;
import com.hp.hpl.jena.query.Query;
import com.hp.hpl.jena.query.QueryExecution;
import com.hp.hpl.jena.query.QueryExecutionFactory;
import com.hp.hpl.jena.query.QueryFactory;
import com.hp.hpl.jena.query.QuerySolution;
import com.hp.hpl.jena.query.ResultSet;
import com.hp.hpl.jena.rdf.model.*;
import com.hp.hpl.jena.reasoner.Reasoner;
import com.hp.hpl.jena.reasoner.ReasonerRegistry;
import com.hp.hpl.jena.reasoner.ValidityReport;
import com.hp.hpl.jena.reasoner.rulesys.GenericRuleReasoner;
import com.hp.hpl.jena.reasoner.rulesys.Rule;
import com.hp.hpl.jena.util.FileManager;


public class HelloSemanticWeb {
	static String defaultNameSpace = "http://www.owl-ontologies.com/Ontology1428263456.owl#";
	
	public Model Mod = null;
	
	public static void main(String[] args) throws IOException {
		
		HelloSemanticWeb hello = new HelloSemanticWeb();
		System.out.println("Loading  Ontology");
		hello.LoadOntology();
	
		System.out.println("\nSPARQL QUERY ANSWER IS :");
		hello.runQuery(" select  ?husband ?wife  where {  ?wife Fam:isWife ?husband . ?husband Fam:isSon_for ?Father. ?Father Fam:hasName ?name.Filter (?name = 'Adam') }  ", hello.Mod);  //add the query string

			System.out.println("\nSuccess!");
	}
	

	
	public void LoadOntology(){
		Mod = ModelFactory.createOntologyModel();
		
	     InputStream inFoafInstance1 = FileManager.get().open("Ontologies/FamOnt.rdf");
	
		Mod.read(inFoafInstance1,defaultNameSpace);
		

	}
	

	


	public void runQuery(String queryRequest, Model model)
	
	{
		
		StringBuffer queryStr = new StringBuffer();
		// Establish Prefixes
		queryStr.append("PREFIX Fam" + ": <" + defaultNameSpace + "> ");
		queryStr.append("PREFIX rdfs" + ": <" + "http://www.w3.org/2000/01/rdf-schema#" + "> ");
		queryStr.append("PREFIX rdf" + ": <" + "http://www.w3.org/1999/02/22-rdf-syntax-ns#" + "> ");
		queryStr.append("PREFIX foaf" + ": <" + "http://xmlns.com/foaf/0.1/" + "> ");
		
		//Now add query
		
		queryStr.append(queryRequest);
		Query query = QueryFactory.create(queryStr.toString());
		QueryExecution qexec = QueryExecutionFactory.create(query, model);
		
try {
			
		ResultSet response = qexec.execSelect();
		
		while( response.hasNext())
		{
			QuerySolution soln = response.nextSolution();
			RDFNode wife = soln.get("?wife");
			RDFNode hus = soln.get("?husband");
			if( wife != null )
			 
			{
			     String Value= wife.toString();
				 String Result =Value.substring(53,Value.length());
				System.out.println( "wife is :" +Result);
				 String Value1= hus.toString();
				 String Result1 =Value1.substring(53,Value1.length());
				System.out.println( "husband is :" +Result1);
			}
			else
				System.out.println("NO Result found !");
	    }
    } 
		
		finally { qexec.close();}				
		}
}