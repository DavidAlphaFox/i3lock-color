# Created by: Dennis Herrmann <dhn@FreeBSD.org>
# $FreeBSD: head/x11/i3lock/Makefile 488442 2018-12-26 21:03:58Z linimon $

PORTNAME=	i3lock-color
PORTVERSION=	2.12.c
CATEGORIES=	x11
MASTER_SITES=	http://i3wm.org/${PORTNAME}/

MAINTAINER=	bapt@FreeBSD.org
COMMENT=	Slightly improved screen locker based on slock

LICENSE=	BSD3CLAUSE
LICENSE_FILE=	${WRKSRC}/LICENSE

LIB_DEPENDS=	libcairo.so:graphics/cairo \
		libxcb-keysyms.so:x11/xcb-util-keysyms \
		libxcb-image.so:x11/xcb-util-image \
		libev.so:devel/libev \
		libxkbfile.so:x11/libxkbfile \
		libxkbcommon.so:x11/libxkbcommon \
		libxcb-util.so:x11/xcb-util \
		libxcb-xrm.so:x11/xcb-util-xrm \
		libjpeg.so:graphics/libjpeg-turbo

MAKE_ARGS=	PREFIX="${PREFIX}" X11LIB="${LOCALBASE}/lib" \
		X11INC="${LOCALBASE}/include" CC="${CC}" \
		MANDIR="${MANPREFIX}/man"

PLIST_FILES=	"@(,,4755) bin/i3lock" \
		man/man1/i3lock.1.gz

USES=		gmake iconv localbase pkgconfig autoreconf 
LDFLAGS+=	${ICONV_LIB}
USE_XORG=	x11 xcb xt xorgproto xext
USE_CSTD=	c99
GNU_CONFIGURE=	yes
BUILD_WRKSRC=	${WRKSRC}/${CONFIGURE_TARGET}
INSTALL_WRKSRC=	${WRKSRC}/${CONFIGURE_TARGET}

PORTDOCS=	CHANGELOG README.md

OPTIONS_DEFINE=	DOCS

post-install:
	@${STRIP_CMD} ${STAGEDIR}${PREFIX}/bin/i3lock
	@${RM} ${STAGEDIR}${PREFIX}/etc/pam.d/i3lock

post-install-DOCS-on:
	@${MKDIR} ${STAGEDIR}${DOCSDIR}
	${INSTALL_DATA} ${PORTDOCS:S|^|${WRKSRC}/|} ${STAGEDIR}${DOCSDIR}

.include <bsd.port.mk>
