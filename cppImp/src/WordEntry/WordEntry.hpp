#ifndef WORDENTRY_HPP
#define WORDENTRY_HPP

#include <string>
#include <vector>
class WordEntry {
  std::string mWord;
  size_t mCount;
  std::vector<size_t> mFileInstances;

public:
  WordEntry(std::string word, size_t count, std::vector<size_t> fileInstances);
  ~WordEntry();
};

#endif
