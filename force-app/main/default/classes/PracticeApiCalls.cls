public class PracticeApiCalls {
    public static ID productHandler() {
        ID jobID = System.enqueueJob(new ApiCallQuable());
        return jobID;
    }
}