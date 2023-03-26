import Foundation

class OpenAI {
//    let apiKey = "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"
    let apiKey = "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"
    let baseURL = "https://api.openai.com/v1/chat/completions"

    // 发送请求并处理响应
    func sendRequest(prompt: String, completion: @escaping (Result<OpenAIResponse, Error>) -> Void) {
        // 创建请求体
        let request = createRequest(prompt: prompt)

        // 创建 URLSessionDataTask
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            // 处理响应
            if let data = data {
                do {
                    let response = try JSONDecoder().decode(OpenAIResponse.self, from: data)
                    completion(.success(response))
                } catch {
                    print("koo----- err :\(error)")
                    completion(.failure(error))
                }
            } else if let error = error {
                completion(.failure(error))
            }
        }

        // 发送请求
        task.resume()
    }

    // 创建请求体
    private func createRequest(prompt: String) -> URLRequest {
        // 创建请求体 JSON 数据
        let jsonData = try! JSONEncoder().encode(OpenAIRequest(prompt: prompt))

        // 创建 URLRequest
        var request = URLRequest(url: URL(string: baseURL)!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.httpBody = jsonData

        return request
    }
}

/**
 {
      "model": "gpt-3.5-turbo",
      "messages": [{"role": "user", "content": "Say this is a test!"}],
      "temperature": 0.7
    }
 */

// OpenAI 请求体
struct OpenAIRequest: Codable {
    let model = "gpt-3.5-turbo"
    let messages: [Message]
    let temperature = 0.7

    init(prompt: String) {
        messages = [Message(role: "user", content: prompt)]
    }
}

// OpenAI 消息
struct Message: Codable, Hashable {
    var id: UUID? = nil // 将 id 属性声明为可选的
    let role: String
    let content: String
}

/** 响应的数据结构
 {
     "id": "chatcmpl-6y544SSE4GfC4o5S2Ex2f79reTIdx",
     "object": "chat.completion",
     "created": 1679777168,
     "model": "gpt-3.5-turbo-0301",
     "usage": {
         "prompt_tokens": 14,
         "completion_tokens": 5,
         "total_tokens": 19
     },
     "choices": [
         {
             "message": {
                 "role": "assistant",
                 "content": "This is a test!"
             },
             "finish_reason": "stop",
             "index": 0
         }
     ]
 }
 */
// OpenAI 响应
struct OpenAIResponse: Codable {
    let choices: [Choice]
    let usage: Usage
    let id: String
    let object: String
    let created: CLong
    let model: String

    struct Choice: Codable {
        let message: Message
        let finish_reason: String
        let index: Int
    }
}

struct Usage: Codable {
    let prompt_tokens: Int
    let completion_tokens: Int
    let total_tokens: Int
}
