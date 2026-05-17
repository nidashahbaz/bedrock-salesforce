/**
 * Utility class for Bedrock Case operations used in the Bedrock Enterprises demo.
 */
public with sharing class BedrockCaseHandler {
    /**
     * Close low-priority Bedrock cases by setting Status__c to Closed.
     */
    public static void closeLowPriorityCases() {
        if (!Schema.sObjectType.Bedrock_Case__c.isAccessible() || !Schema.sObjectType.Bedrock_Case__c.isUpdateable()) {
            return;
        }
        List<Bedrock_Case__c> casesToClose = [
            SELECT Id, Status__c
            FROM Bedrock_Case__c
            WHERE Priority__c = 'Low' AND Status__c != 'Closed'
        ];
        for (Bedrock_Case__c caseRecord : casesToClose) {
            caseRecord.Status__c = 'Closed';
        }
        if (!casesToClose.isEmpty()) {
            update casesToClose;
        }
    }
}
