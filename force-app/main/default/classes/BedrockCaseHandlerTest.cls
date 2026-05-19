@IsTest
// DemoNida: Added/verified test for closeLowPriorityCases (2026-05-19)
private class BedrockCaseHandlerTest {
    @IsTest static void testCloseLowPriorityCases() {
        List<Bedrock_Case__c> caseRecords = new List<Bedrock_Case__c>{
            new Bedrock_Case__c(
                Name='Low Priority Case',
                Priority__c='Low',
                Status__c='Open',
                Description__c='Low priority case for test'
            ),
            new Bedrock_Case__c(
                Name='High Priority Case',
                Priority__c='High',
                Status__c='In Progress',
                Description__c='High priority case for test'
            )
        };
        insert caseRecords;

        Test.startTest();
            BedrockCaseHandler.closeLowPriorityCases();
        Test.stopTest();

        Map<Id, Bedrock_Case__c> savedCases = new Map<Id, Bedrock_Case__c>([
            SELECT Priority__c, Status__c
            FROM Bedrock_Case__c
            WHERE Id IN :caseRecords
        ]);

        System.assertEquals('Closed', savedCases.get(caseRecords[0].Id).Status__c, 'Low priority case should be closed.');
        System.assertEquals('In Progress', savedCases.get(caseRecords[1].Id).Status__c, 'High priority case should remain unchanged.');
    }
}
