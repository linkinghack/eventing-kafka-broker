/*
 * Copyright © 2018 Knative Authors (knative-dev@googlegroups.com)
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package dev.knative.eventing.kafka.broker.dispatcher.impl;

import java.net.http.HttpResponse;

public class ResponseFailureException extends RuntimeException {

  private final HttpResponse<?> response;

  public ResponseFailureException(final HttpResponse response, final String msg) {
    super(msg);
    this.response = response;
  }

  public ResponseFailureException(final HttpResponse<?> response,
                                  final Throwable ex) {
    super(ex);
    this.response = response;
  }

  public HttpResponse<?> getResponse() {
    return response;
  }
}
