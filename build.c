#include <sys/stat.h>
#include <assert.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

// You can get this path with 'xcrun --show-sdk-path --sdk iphoneos'
#define SDK_PATH "/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS17.5.sdk"
#define TARGET "arm64-apple-ios17.0"

static void usage() {
  fprintf(stderr, "just call 'build' without arguments\n");
}

static int run(char ** args) {
  assert(args && args[0]);

  pid_t pid = fork();
  if (pid == 0) {
    execvp(args[0], args);
    abort();
  } else if (pid > 0) {
    int sl = 0;
    assert(0 <= waitpid(pid, &sl, 0));
    if (WIFEXITED(sl)) return WEXITSTATUS(sl);
  }

  fprintf(stderr, "failed to run child process: %s\n", args[0]);
  return 1;
}

static int validate() {
  char * api_key = getenv("IOS_API_KEY");
  assert(api_key && "Missing IOS_API_KEY environment variable");
  char * api_issuer = getenv("IOS_API_ISSUER");
  assert(api_issuer && "Missing IOS_API_ISSUER environment variable");

  char * args[] = {
    "xcrun", "altool", "--validate-app", "-t", "iphoneos",
    "-f", "main.ipa",
    "--apiKey", strdup(api_key),
    "--apiIssuer", strdup(api_issuer),
    0 };
  return run(args);
}

static int cc(char * src, char * exe) {
  char * args[] = {
    "clang", "-Wall", "-O3", "-target", TARGET, "-isysroot", SDK_PATH,
    "-framework", "UIKit",
    "-o", exe, src, 0 };
  return run(args);
}

int main(int argc, char ** argv) {
  if (argc != 1) return (usage(), 1);

  if (cc("main.m", "main.app/main")) return 1;

  if (validate()) return 1;

  return 0;
}
