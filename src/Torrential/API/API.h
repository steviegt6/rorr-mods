#pragma once

#ifdef TORRENTIAL_PLUGIN
#define TORRENTIAL_EXPORT extern "C" __declspec(dllimport)
#else
#define TORRENTIAL_EXPORT extern "C" __declspec(dllexport)
#endif

namespace Torrential::API
{
	struct APIFeature
	{
		char* modName;
		char* featureName;
	};

	static const char* TORRENTIAL_API_VERSION = "0.1.0";

	TORRENTIAL_EXPORT bool SupportsAPIFeature(APIFeature feature);
}