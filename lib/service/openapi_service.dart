abstract class OpenAPIService {
  Future<String> isArtPrompt(String prompt);
  Future<String> chatGPTAPI(String prompt);
  Future<String> dallEAPI(String prompt);
}
