FROM openjdk:8-jdk

MAINTAINER Dylan <bbcheng@ikuai8.com>

###########################################################
# locale
ENV OS_LOCALE="en_US.UTF-8"
RUN apt-get update \
	&& DEBIAN_FRONTEND=noninteractive \
	&& apt-get install -y locales \
	&& sed -i -e "s/# ${OS_LOCALE} UTF-8/${OS_LOCALE} UTF-8/" /etc/locale.gen \
	&& locale-gen
ENV LANG=${OS_LOCALE} \
	LC_ALL=${OS_LOCALE} \
	LANGUAGE=en_US:en

###########################################################
# timezone
RUN DEBIAN_FRONTEND=noninteractive \
	apt-get install -y tzdata \
	&& ln -fs /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
	&& dpkg-reconfigure -f noninteractive tzdata \
	### clean
	&& apt-get autoremove -y \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/*

CMD ["/bin/bash"]
